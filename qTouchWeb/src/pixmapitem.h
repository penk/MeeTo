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

#ifndef PIXMAPITEM_H
#define PIXMAPITEM_H

#include <QPixmap>
#include <QDeclarativeItem>

class PixmapItem : public QDeclarativeItem
{
    Q_OBJECT
    Q_PROPERTY(bool smooth READ smooth WRITE setSmooth NOTIFY smoothChanged);
    Q_PROPERTY(QPixmap pixmap READ pixmap WRITE setPixmap NOTIFY pixmapChanged);

public:
    PixmapItem(QDeclarativeItem *parent = 0);
    virtual ~PixmapItem();

    bool smooth() const;
    void setSmooth(bool enabled);

    QPixmap pixmap() const;
    void setPixmap(const QPixmap &pixmap);

    void paint(QPainter *painter, const QStyleOptionGraphicsItem *option,
               QWidget *widget = 0);

signals:
    void smoothChanged();
    void pixmapChanged();

private:
    bool m_smooth;
    QPixmap m_pixmap;
};

QML_DECLARE_TYPE(PixmapItem);

#endif
