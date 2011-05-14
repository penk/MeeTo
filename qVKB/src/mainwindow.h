#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QDeclarativeItem>
#include <QDeclarativeView>
#include "sendkey.h"

class MainWindow : public QDeclarativeView
{
    Q_OBJECT

public:
    MainWindow();

public:
    void toggle();
    void focusin();
    void focusout();

public:
    QDeclarativeItem *rootItem;
    Keyboard keyboard;
};

#endif
