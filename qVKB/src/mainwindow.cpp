#include "mainwindow.h"
#include "sendkey.h"

#include <QApplication>
#include <QDeclarativeView>
#include <QDeclarativeEngine>
#include <QDeclarativeContext>

MainWindow::MainWindow()
    : QDeclarativeView()
{

    QDeclarativeContext *context = engine()->rootContext();
    context->setContextProperty("Keyboard", &keyboard);

    QPalette palette;
    palette.setColor(QPalette::Base, Qt::transparent);

    setPalette(palette);
    setAttribute(Qt::WA_TranslucentBackground, true);
    setSource(QUrl("qrc:/layout.qml"));

    rootItem = qobject_cast<QDeclarativeItem *>(rootObject());
    Q_ASSERT(rootItem);
}

void MainWindow::toggle()
{
    QMetaObject::invokeMethod(rootItem, "toggle");
}

void MainWindow::focusin()
{
    QMetaObject::invokeMethod(rootItem, "focusin");
}

void MainWindow::focusout()
{
    QMetaObject::invokeMethod(rootItem, "focusout");
}
