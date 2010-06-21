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

#ifndef KINETICSCROLL_H
#define KINETICSCROLL_H

#include <QObject>
#include <QPoint>

class KineticScrollPrivate;

class KineticScroll : public QObject
{
    Q_OBJECT

public:
    KineticScroll(QObject *parent = 0);
    ~KineticScroll();

    bool mousePress(const QPoint &value);
    void mouseMove(const QPoint &value);
    void mouseRelease(const QPoint &value);

    bool isAnimating() const;
    void stop();

protected Q_SLOTS:
    void tick();
    void start(const QPointF &speed);

Q_SIGNALS:
    void offsetChanged(const QPoint &);

private:
    KineticScrollPrivate *d;
};

#endif
