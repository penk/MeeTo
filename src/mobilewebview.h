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

#ifndef MOBILEWEBVIEW_H
#define MOBILEWEBVIEW_H

#include <QGraphicsWebView>
#include <QDeclarativeItem>


class MobileWebViewPrivate;

class MobileWebView : public QDeclarativeItem
{
    Q_OBJECT
    Q_PROPERTY(QString title READ title);
    Q_PROPERTY(QString url READ url WRITE setUrl);
    Q_PROPERTY(bool frozen READ isFrozen WRITE setFrozen);
    Q_PROPERTY(qreal zoomScale READ zoomScale WRITE setZoomScale);
    Q_PROPERTY(QPointF contentPos READ contentPos WRITE setContentPos);

public:
    MobileWebView(QDeclarativeItem *parent = 0);
    virtual ~MobileWebView();

    QString title() const;

    QString url() const;
    void setUrl(const QString &url);

    bool isFrozen() const;
    void setFrozen(bool enabled);

    qreal zoomScale() const;
    void setZoomScale(qreal value);

    QPointF contentPos() const;
    void setContentPos(const QPointF &pos);

    Q_INVOKABLE void back();
    Q_INVOKABLE void forward();
    Q_INVOKABLE void reload();
    Q_INVOKABLE void stop();

    Q_INVOKABLE QPixmap snapshot(int w, int h) const;

signals:
    void urlChanged();
    void loadFinished(bool ok);
    void loadProgress(int progress);
    void titleChanged(const QString &title);

protected slots:
    void moveOffset(const QPoint &offset);
    void onUrlChanged();
    void enableContentUpdate();
    void onFadeScrollTimeout();
    void onInitialLayoutCompleted();
    void onContentsSizeChanged(const QSize &newSize);

protected:
    bool eventFilter(QObject *object, QEvent *e);
    bool handleMouseEvent(QGraphicsSceneMouseEvent *e);
    void geometryChanged(const QRectF &newGeometry,
                         const QRectF &oldGeometry);

private:
    MobileWebViewPrivate *dd;
};

QML_DECLARE_TYPE(MobileWebView);

#endif
