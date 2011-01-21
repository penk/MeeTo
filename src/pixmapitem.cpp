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

#include "pixmapitem.h"

#include <QPainter>


PixmapItem::PixmapItem(QDeclarativeItem *parent)
    : QDeclarativeItem(parent),
      m_smooth(false)
{
    setFlag(QGraphicsItem::ItemHasNoContents, false);
}

PixmapItem::~PixmapItem()
{

}

bool PixmapItem::smooth() const
{
    return m_smooth;
}

void PixmapItem::setSmooth(bool enabled)
{
    if (m_smooth != enabled) {
        m_smooth = enabled;
        emit smoothChanged();
    }
}

QPixmap PixmapItem::pixmap() const
{
    return m_pixmap;
}

void PixmapItem::setPixmap(const QPixmap &pixmap)
{
    m_pixmap = pixmap;
    setImplicitWidth(m_pixmap.width());
    setImplicitHeight(m_pixmap.height());
    update();
}

void PixmapItem::paint(QPainter *painter, const QStyleOptionGraphicsItem *, QWidget *)
{
    if (m_pixmap.isNull())
        return;

    const bool oldSmooth = (painter->renderHints() & QPainter::SmoothPixmapTransform);
    const bool smoothChange = (oldSmooth != m_smooth);

    painter->save();

    if (smoothChange)
        painter->setRenderHint(QPainter::SmoothPixmapTransform, m_smooth);

    painter->scale(width() / m_pixmap.width(), height() / m_pixmap.height());
    painter->drawPixmap(0, 0, m_pixmap);

    if (smoothChange)
        painter->setRenderHint(QPainter::SmoothPixmapTransform, oldSmooth);

    painter->restore();
}
