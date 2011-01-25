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

#ifndef SCROLLBAR_H
#define SCROLLBAR_H

#include <QGraphicsWidget>

class QPixmap;
class QGraphicsItem;
class ScrollBarPrivate;


class ScrollBar : public QGraphicsWidget
{
    Q_OBJECT

public:
    ScrollBar(Qt::Orientation orientation = Qt::Vertical,
              QGraphicsItem *parent = 0);

    int value() const;
    void setValue(int value);

    int maximum() const;
    void setMaximum(int maximum);

    int pageSize() const;
    void setPageSize(int pageSize);

    void setForegroundColor(const QColor &color);
    void setBackgroundColor(const QColor &color);

protected:
    void resizeEvent(QGraphicsSceneResizeEvent *event);
    void paint(QPainter *painter, const QStyleOptionGraphicsItem *option, QWidget *widget = 0);

private:
    ScrollBarPrivate *d;
    friend class ScrollBarPrivate;
};

#endif
