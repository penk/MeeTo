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

#include "mobilewebview.h"
#include "mobilewebpage.h"
#include "scrollbar.h"
#include "kineticscroll.h"

#include <QTimer>
#include <QWebFrame>
#include <QApplication>
#include <QGraphicsScene>
#include <QPropertyAnimation>
#include <QParallelAnimationGroup>
#include <QGraphicsSceneMouseEvent>

#define CLICK_CONSTANT 15
#define TILE_FROZEN_DELAY 100
#define FADE_SCROLL_TIMEOUT 300
#define MIN_ZOOM_SCALE 0.1
#define MAX_ZOOM_SCALE 6.0
#define DPI_ADJUSTMENT_SCALE 1.0


class MobileWebViewPrivate
{
public:
    MobileWebViewPrivate(MobileWebView *qptr);

    MobileWebView *q;
    KineticScroll *kinetic;

    ScrollBar *verticalScroll;
    ScrollBar *horizontalScroll;

    bool isDragging;
    bool acceptsClick;
    QPoint pressPos;
    QPoint scenePressPos;
    QList<QEvent *> ignored;

    QTimer timer;
    bool scrollVisible;
    QTimer fadeScrollTimer;
    QGraphicsWebView *webview;

    void init();
    void updateScrollBars();
    QRectF contentGeometry() const;
    void setContentPos(const QPointF &pos);
    void sendSceneClick(const QPointF &pos);
    bool isClickPossible(const QPoint &pos);
    void setScrollBarsVisible(bool visible);
};

MobileWebViewPrivate::MobileWebViewPrivate(MobileWebView *qptr)
    : q(qptr), isDragging(false),
      acceptsClick(true), scrollVisible(false)
{
    kinetic = new KineticScroll(q);
}

void MobileWebViewPrivate::init()
{
    q->setFlag(QGraphicsItem::ItemHasNoContents, true);
    q->setFlag(QGraphicsItem::ItemClipsChildrenToShape, true);

    verticalScroll = new ScrollBar(Qt::Vertical, q);
    verticalScroll->setBackgroundColor(Qt::transparent);
    verticalScroll->setForegroundColor(Qt::gray);
    verticalScroll->setZValue(1);
    verticalScroll->setOpacity(0.0);

    horizontalScroll = new ScrollBar(Qt::Horizontal, q);
    horizontalScroll->setBackgroundColor(Qt::transparent);
    horizontalScroll->setForegroundColor(Qt::gray);
    horizontalScroll->setZValue(1);
    horizontalScroll->setOpacity(0.0);

    webview = new QGraphicsWebView(q);
    webview->installEventFilter(q);
    webview->setResizesToContents(true);
    webview->setAttribute(Qt::WA_OpaquePaintEvent, true);

    MobileWebPage *page = new MobileWebPage(q);
    webview->setPage(page);

    timer.setSingleShot(true);
    fadeScrollTimer.setSingleShot(true);

    QObject::connect(&fadeScrollTimer, SIGNAL(timeout()), q, SLOT(onFadeScrollTimeout()));

    // connect frozen tile timer delay
    QObject::connect(&timer, SIGNAL(timeout()), q, SLOT(enableContentUpdate()));

    // connect kinetic signals
    QObject::connect(kinetic, SIGNAL(offsetChanged(const QPoint &)),
                     q, SLOT(moveOffset(const QPoint &)));

    // connect webview signals
    QObject::connect(webview, SIGNAL(loadProgress(int)), q, SIGNAL(loadProgress(int)));
    QObject::connect(webview, SIGNAL(loadFinished(bool)), q, SIGNAL(loadFinished(bool)));
    QObject::connect(webview, SIGNAL(urlChanged(const QUrl &)), q, SLOT(onUrlChanged()));
    QObject::connect(webview, SIGNAL(titleChanged(const QString &)),
                     q, SIGNAL(titleChanged(const QString &)));
    QObject::connect(webview->page()->mainFrame(), SIGNAL(contentsSizeChanged(const QSize &)),
                     q, SLOT(onContentsSizeChanged(const QSize &)));
    QObject::connect(webview->page()->mainFrame(), SIGNAL(initialLayoutCompleted()),
                     q, SLOT(onInitialLayoutCompleted()));

    webview->setScale(DPI_ADJUSTMENT_SCALE);
}

QRectF MobileWebViewPrivate::contentGeometry() const
{
    return QRectF(webview->x(), webview->y(),
                  webview->size().width() * webview->scale(),
                  webview->size().height() * webview->scale());
}

void MobileWebViewPrivate::setScrollBarsVisible(bool visible)
{
    if (scrollVisible == visible)
        return;

    scrollVisible = visible;

    QParallelAnimationGroup *result = new QParallelAnimationGroup(q);
    QPropertyAnimation *animation;

    animation = new QPropertyAnimation(verticalScroll, "opacity");
    animation->setDuration(400);
    animation->setStartValue(verticalScroll->opacity());
    animation->setEndValue(visible ? 0.7 : 0);
    result->addAnimation(animation);

    animation = new QPropertyAnimation(horizontalScroll, "opacity");
    animation->setDuration(400);
    animation->setStartValue(horizontalScroll->opacity());
    animation->setEndValue(visible ? 0.7 : 0);
    result->addAnimation(animation);

    result->start(QAbstractAnimation::DeleteWhenStopped);
}

bool MobileWebViewPrivate::isClickPossible(const QPoint &pos)
{
    if (kinetic->isAnimating() || !acceptsClick)
        return false;
    else
        return abs(pos.x() - pressPos.x()) <= CLICK_CONSTANT
            && abs(pos.y() - pressPos.y()) <= CLICK_CONSTANT;
}

void MobileWebViewPrivate::setContentPos(const QPointF &pos)
{
    const QSizeF &webSize = contentGeometry().size();

    int minX = qMin<int>(0, q->width() - webSize.width());
    int minY = qMin<int>(0, q->height() - webSize.height());

    // enforce boundaries
    webview->setX(qBound<int>(minX, pos.x(), 0));
    webview->setY(qBound<int>(minY, pos.y(), 0));
    updateScrollBars();
}

void MobileWebViewPrivate::updateScrollBars()
{
    const QSizeF &webSize = contentGeometry().size();

    verticalScroll->setGeometry(q->width() - 10, 14, 7, q->height() - 28);
    horizontalScroll->setGeometry(14, q->height() - 10, q->width() - 28, 7);

    verticalScroll->setValue(-webview->y());
    verticalScroll->setPageSize(q->height());
    verticalScroll->setMaximum(-qMin<int>(0, q->height() - webSize.height()));

    horizontalScroll->setValue(-webview->x());
    horizontalScroll->setPageSize(q->width());
    horizontalScroll->setMaximum(-qMin<int>(0, q->width() - webSize.width()));

    setScrollBarsVisible(true);

    fadeScrollTimer.start(FADE_SCROLL_TIMEOUT);
}

void MobileWebViewPrivate::sendSceneClick(const QPointF &pos)
{
    QGraphicsSceneMouseEvent *event;

    event = new QGraphicsSceneMouseEvent(QEvent::GraphicsSceneMousePress);
    event->setButton(Qt::LeftButton);
    event->setScenePos(pos);
    ignored << event;
    QCoreApplication::postEvent(q->scene(), event);

    event = new QGraphicsSceneMouseEvent(QEvent::GraphicsSceneMouseRelease);
    event->setButton(Qt::LeftButton);
    event->setScenePos(pos);
    ignored << event;
    QCoreApplication::postEvent(q->scene(), event);
}



MobileWebView::MobileWebView(QDeclarativeItem *parent)
    : QDeclarativeItem(parent)
{
    dd = new MobileWebViewPrivate(this);
    dd->init();
    dd->updateScrollBars();
}

MobileWebView::~MobileWebView()
{
    delete dd;
}

QString MobileWebView::title() const
{
    return dd->webview->title();
}

QString MobileWebView::url() const
{
    return dd->webview->url().toString();
}

void MobileWebView::setUrl(const QString &url)
{
    dd->webview->setUrl(QUrl::fromUserInput(url));
}

bool MobileWebView::isFrozen() const
{
    return dd->webview->isTiledBackingStoreFrozen();
}

void MobileWebView::setFrozen(bool enabled)
{
    dd->webview->setTiledBackingStoreFrozen(enabled);
}

QPointF MobileWebView::contentPos() const
{
    return dd->webview->pos();
}

void MobileWebView::setContentPos(const QPointF &pos)
{
    dd->setContentPos(pos);
}

void MobileWebView::back()
{
    dd->webview->back();
}

void MobileWebView::forward()
{
    dd->webview->forward();
}

void MobileWebView::reload()
{
    dd->webview->reload();
}

void MobileWebView::stop()
{
    dd->webview->stop();
}

void MobileWebView::onUrlChanged()
{
    emit urlChanged();
}

bool MobileWebView::handleMouseEvent(QGraphicsSceneMouseEvent *e)
{
    if (dd->ignored.removeAll(e))
        return false;

    const QPoint &mousePos = e->screenPos();

    if (e->type() == QEvent::GraphicsSceneMouseDoubleClick) {
        setZoomScale(1.5);

        qDebug() << "double click";
        return true;
    }

    if (e->type() == QEvent::GraphicsSceneMousePress) {
        if (e->buttons() != Qt::LeftButton)
            return false;

        dd->acceptsClick = !dd->kinetic->isAnimating();

        dd->kinetic->mousePress(mousePos);

        dd->isDragging = false;

        dd->pressPos = mousePos;
        dd->scenePressPos = e->scenePos().toPoint();
        return true;
    }

    if (e->type() == QEvent::GraphicsSceneMouseMove) {
        if (!dd->isClickPossible(mousePos))
            dd->isDragging = true;

        if (dd->isDragging) {
            dd->kinetic->mouseMove(mousePos);
        } else {
            dd->kinetic->mousePress(mousePos);
        }
        return true;
    }

    if (e->type() == QEvent::GraphicsSceneMouseRelease) {
        if (dd->isClickPossible(mousePos)) {
            dd->kinetic->stop();
            dd->sendSceneClick(dd->scenePressPos);
        } else {
            dd->kinetic->mouseRelease(mousePos);
        }

        dd->acceptsClick = true;
        return true;
    }

    return false;
}

void MobileWebView::moveOffset(const QPoint &value)
{
    const QPoint &oldPos = dd->webview->pos().toPoint();
    dd->setContentPos(dd->webview->pos() + value);

    if (dd->webview->pos().toPoint() == oldPos)
        dd->kinetic->stop();

    setFrozen(true);
    dd->timer.start(TILE_FROZEN_DELAY);
}

bool MobileWebView::eventFilter(QObject *object, QEvent *e)
{
    switch(e->type()) {
    case QEvent::GraphicsSceneMousePress:
    case QEvent::GraphicsSceneMouseMove:
    case QEvent::GraphicsSceneMouseRelease:
    case QEvent::GraphicsSceneMouseDoubleClick:
        return handleMouseEvent(static_cast<QGraphicsSceneMouseEvent *>(e));
//    case QEvent::GraphicsSceneContextMenu:
        // ignore native context menu
//        return true;
    case QEvent::GraphicsSceneHoverMove:
    case QEvent::GraphicsSceneHoverLeave:
    case QEvent::GraphicsSceneHoverEnter:
        // ignore hover events
        return true;
    default:
        return QObject::eventFilter(object, e);
    }
}

void MobileWebView::enableContentUpdate()
{
    setFrozen(false);
}

void MobileWebView::onInitialLayoutCompleted()
{
    dd->kinetic->stop();
    dd->setContentPos(QPointF(0, 0));
}

void MobileWebView::onContentsSizeChanged(const QSize &newSize)
{
    Q_UNUSED(newSize);
    // enforce boundaries
    dd->kinetic->stop();
    dd->setContentPos(dd->webview->pos());
}

void MobileWebView::geometryChanged(const QRectF &newGeometry,
                                    const QRectF &oldGeometry)
{
    QDeclarativeItem::geometryChanged(newGeometry, oldGeometry);
    // enforce boundaries
    dd->kinetic->stop();
    dd->setContentPos(dd->webview->pos());
    // reconfigure preferred size
    dd->webview->page()->setPreferredContentsSize(newGeometry.size().toSize() / DPI_ADJUSTMENT_SCALE);
}

void MobileWebView::onFadeScrollTimeout()
{
    dd->setScrollBarsVisible(false);
}

qreal MobileWebView::zoomScale() const
{
    return dd->webview->scale();
}

void MobileWebView::setZoomScale(qreal value)
{
    value = qBound<qreal>(MIN_ZOOM_SCALE, value, MAX_ZOOM_SCALE);

    if (value != zoomScale()) {
        dd->webview->setScale(value * DPI_ADJUSTMENT_SCALE);
    } 

    // fallback to normal at the second double-tap
    else { dd->webview->setScale( 1.0 * DPI_ADJUSTMENT_SCALE); } 
}

QPixmap MobileWebView::snapshot(int w, int h) const
{
    QImage result(w, h, QImage::Format_RGB32);

    QPainter painter(&result);
    painter.fillRect(result.rect(), Qt::white);

    if (!dd->webview->url().isEmpty()) {
        qreal scale = dd->webview->scale();

        int ix = dd->webview->pos().x();
        int iy = dd->webview->pos().y();

        painter.translate(ix, iy);
        painter.scale(scale, scale);

        dd->webview->page()->mainFrame()->render(&painter, QWebFrame::ContentsLayer,
                                                 QRegion(-ix / scale, -iy / scale, w / scale, h / scale));
    }

    return QPixmap::fromImage(result);
}
