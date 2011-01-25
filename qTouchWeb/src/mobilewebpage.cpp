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

#include "mobilewebpage.h"

#include <QVariant>

#define TILE_CREATION_DELAY 20
#define TILE_SIZE QSize(256, 256)
#define TILE_AREA_RANGE QSizeF(4.0, 4.0)


MobileWebPage::MobileWebPage(QObject *parent)
    : QWebPage(parent)
{
    // setup tile settings
    setProperty("_q_TiledBackingStoreTileSize", TILE_SIZE);
    setProperty("_q_TiledBackingStoreKeepAreaMultiplier", TILE_AREA_RANGE);
    setProperty("_q_TiledBackingStoreCoverAreaMultiplier", TILE_AREA_RANGE);
    setProperty("_q_TiledBackingStoreTileCreationDelay", TILE_CREATION_DELAY);
}

MobileWebPage::~MobileWebPage()
{

}

QString MobileWebPage::userAgentForUrl(const QUrl &url) const
{
#if defined(Q_OS_LINUX)
    // simulate iPad
    return QWebPage::userAgentForUrl(url)
        .replace("Linux i686", "CPU OS 4_2 like Mac OS X").replace("X11", "iPad");
#else
    return QWebPage::userAgentForUrl(url);
#endif
}
