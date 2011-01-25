/****************************************************************************
**
** Copyright (C) 2010 Instituto Nokia de Tecnologia (INdT)
**
** This file is part of the Rask Browser project.
**
** This file may be used under the terms of the GNU Lesser
** General Public License version 2.1 as published by the Free Software
** Foundation and appearing in the file LICENSE.LGPL included in the
** packaging of this file.  Please review the following information to
** ensure the GNU Lesser General Public License version 2.1 requirements
** will be met: http://www.gnu.org/licenses/old-licenses/lgpl-2.1.html.
**
** If you have questions regarding the use of this file, please contact
** the openBossa stream from INdT <renato.chencarek@openbossa.org>.
**
****************************************************************************/

#include "kineticscroll.h"

#include <QTime>
#include <QTimer>
#include <QPointF>

#define MAX_SPEED 2000
#define KINETIC_FRICTION 0.9
#define KINETIC_TICK_TIME 20


class KineticScrollPrivate
{
public:
    QTimer timer;
    QPointF speed;
    QPointF accel;
    QTime time;
    QTime lastTime;
    QPoint value;
    QPoint lastValue;
    bool isPressed;
    QPoint direction;
};


KineticScroll::KineticScroll(QObject *parent)
    : QObject(parent), d(new KineticScrollPrivate)
{
    d->isPressed = false;
    connect(&d->timer, SIGNAL(timeout()), SLOT(tick()));
}

KineticScroll::~KineticScroll()
{
    delete d;
}

bool KineticScroll::isAnimating() const
{
    return d->timer.isActive();
}

bool KineticScroll::mousePress(const QPoint &value)
{
    d->isPressed = true;

    bool isActive = d->timer.isActive();
    if (isActive)
        d->timer.stop();

    d->value = d->lastValue = value;
    d->time = d->lastTime = QTime::currentTime();
    return !isActive;
}

void KineticScroll::mouseMove(const QPoint &value)
{
    if (!d->isPressed || d->timer.isActive())
        return;

    const QPoint &dv = (value - d->value);

    d->lastValue = d->value;
    d->value = value;
    d->lastTime = d->time;
    d->time = QTime::currentTime();

    if (!dv.isNull())
        emit offsetChanged(dv);
}

void KineticScroll::mouseRelease(const QPoint &value)
{
    if (!d->isPressed || d->timer.isActive())
        return;

    d->isPressed = false;

    const QPointF &dv = (value - d->lastValue);
    qreal dt = d->lastTime.msecsTo(QTime::currentTime()) / 1000.0;

    if (dt != 0)
        start(dv / dt);
}

void KineticScroll::start(const QPointF &value)
{
    d->speed = value;
    d->speed.setX(qBound<qreal>(-MAX_SPEED, d->speed.x(), MAX_SPEED));
    d->speed.setY(qBound<qreal>(-MAX_SPEED, d->speed.y(), MAX_SPEED));

    d->time = QTime::currentTime();
    d->accel = -d->speed * KINETIC_FRICTION;

    d->direction = QPoint(d->speed.x() < 0 ? -1 : 1,
                          d->speed.y() < 0 ? -1 : 1);

    d->timer.start(KINETIC_TICK_TIME);
}

void KineticScroll::stop()
{
    if (d->timer.isActive()) {
        d->isPressed = false;
        d->timer.stop();
    }
}

void KineticScroll::tick()
{
    const QTime &now = QTime::currentTime();
    const qreal dt = d->time.msecsTo(now) / 1000.0;
    const QPointF &speed = (d->speed + d->accel * dt);
    const QPoint &value = (d->speed * dt + d->accel * dt * dt / 2).toPoint();

    if (((value.x() >= 0 && d->direction.x() < 0) || (value.x() <= 0 && d->direction.x() > 0)) &&
        ((value.y() >= 0 && d->direction.y() < 0) || (value.y() <= 0 && d->direction.y() > 0)))
        stop();
    else {
        d->speed = speed;
        d->time = now;
        emit offsetChanged(value);
    }
}
