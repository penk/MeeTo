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

#include <QPen>
#include <QPainter>

#include "scrollbar.h"

#define MIN_KNOB_SIZE 8


class ScrollBarPrivate
{
public:
    ScrollBarPrivate(ScrollBar *qptr);
    void updateKnob();

    ScrollBar *q;
    int value;
    int pageSize;
    int maximum;
    QRectF knobRect;
    QColor foregroundColor;
    QColor backgroundColor;
    Qt::Orientation orientation;
};

ScrollBarPrivate::ScrollBarPrivate(ScrollBar *qptr)
    : q(qptr), value(0), pageSize(10), maximum(100),
      foregroundColor(Qt::gray), backgroundColor(Qt::black)
{

}

void ScrollBarPrivate::updateKnob()
{
    if (orientation == Qt::Vertical) {
        qreal th = q->size().height();
        qreal fh = ((qreal)pageSize / qMax(pageSize + maximum, 1)) * th;
        int kh = qBound<qreal>(MIN_KNOB_SIZE, fh, th);

        knobRect = QRectF(0, (value * qMax<qreal>(0, th - kh)) / qMax(1, maximum), q->size().width(), kh);
    } else {
        qreal tw = q->size().width();
        qreal fw = ((qreal)pageSize / qMax(pageSize + maximum, 1)) * tw;
        int kw = qBound<qreal>(MIN_KNOB_SIZE, fw, tw);

        knobRect = QRectF((value * qMax<qreal>(0, tw - kw)) / qMax(1, maximum), 0, kw, q->size().height());
    }

    q->update();
}


ScrollBar::ScrollBar(Qt::Orientation orientation,
                     QGraphicsItem *parent)
    : QGraphicsWidget(parent),
      d(new ScrollBarPrivate(this))
{
    d->orientation = orientation;
    d->updateKnob();
}

void ScrollBar::setForegroundColor(const QColor &color)
{
    d->foregroundColor = color;
}

void ScrollBar::setBackgroundColor(const QColor &color)
{
    d->backgroundColor = color;
}

int ScrollBar::value() const
{
    return d->value;
}

void ScrollBar::setValue(int value)
{
    if (d->value != value) {
        d->value = value;
        d->updateKnob();
    }
}

int ScrollBar::maximum() const
{
    return d->maximum;
}

void ScrollBar::setMaximum(int maximum)
{
    if (d->maximum != maximum) {
        d->maximum = maximum;
        d->updateKnob();
    }
}

int ScrollBar::pageSize() const
{
    return d->pageSize;
}

void ScrollBar::setPageSize(int pageSize)
{
    if (d->pageSize != pageSize) {
        d->pageSize = pageSize;
        d->updateKnob();
    }
}

void ScrollBar::resizeEvent(QGraphicsSceneResizeEvent *event)
{
    QGraphicsWidget::resizeEvent(event);
    d->updateKnob();
}

void ScrollBar::paint(QPainter *painter, const QStyleOptionGraphicsItem *option,
                      QWidget *widget)
{
    Q_UNUSED(option);
    Q_UNUSED(widget);

    painter->setPen(Qt::NoPen);

    bool noAntialiasing = !(painter->renderHints() & QPainter::Antialiasing);

    if (noAntialiasing)
        painter->setRenderHint(QPainter::Antialiasing);

    painter->setBrush(d->backgroundColor);
    painter->drawRoundedRect(boundingRect(), 4, 4);

    painter->setBrush(d->foregroundColor);
    painter->drawRoundedRect(d->knobRect, 4, 4);

    if (noAntialiasing)
        painter->setRenderHint(QPainter::Antialiasing, false);
}
