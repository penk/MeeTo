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

#include "mainwindow.h"

#include <QApplication>
#include <QWebSettings>
#include <QDeclarativeContext>

#define WEB_MAX_PAGES_IN_CACHE 5
#define WEB_MAX_CACHE_SIZE ((16 * 1024 * 1024) / 8)


MainWindow::MainWindow()
    : QGraphicsView()
{
    setScene(&scene);
    setFrameShape(QFrame::NoFrame);

    setupWebSettings();

    QDeclarativeComponent component(&engine, QUrl("qrc:/main.qml"));
    rootItem = qobject_cast<QDeclarativeItem *>(component.create());

    Q_ASSERT(rootItem);

    scene.addItem(rootItem);
    resize(rootItem->width(), rootItem->height());
    setSceneRect(0, 0, rootItem->width(), rootItem->height());

    connect(rootItem, SIGNAL(close()), qApp, SLOT(quit()));

#if defined(Q_WS_MAEMO_5) && QT_VERSION >= QT_VERSION_CHECK(4, 6, 2)
    setAttribute(Qt::WA_Maemo5AutoOrientation, true);
#endif
}

void MainWindow::resizeEvent(QResizeEvent *event)
{
    QGraphicsView::resizeEvent(event);

    rootItem->setWidth(width());
    rootItem->setHeight(height());
    setSceneRect(0, 0, width(), height());
}

void MainWindow::setupWebSettings()
{
    QWebSettings *settings = QWebSettings::globalSettings();

    settings->setAttribute(QWebSettings::ZoomTextOnly, false);
    settings->setAttribute(QWebSettings::PluginsEnabled, false);
    settings->setAttribute(QWebSettings::LocalStorageEnabled, true);
    settings->setAttribute(QWebSettings::FrameFlatteningEnabled, true);
    settings->setAttribute(QWebSettings::DeveloperExtrasEnabled, true);
    settings->setAttribute(QWebSettings::TiledBackingStoreEnabled, true);
    settings->setAttribute(QWebSettings::LocalContentCanAccessRemoteUrls, true);

    QWebSettings::setMaximumPagesInCache(WEB_MAX_PAGES_IN_CACHE);
    QWebSettings::setObjectCacheCapacities(WEB_MAX_CACHE_SIZE, WEB_MAX_CACHE_SIZE, WEB_MAX_CACHE_SIZE);
}
