#include <QApplication>
#include <QDeclarativeView>
#include <QDeclarativeItem>
#include <QDeclarativeEngine>
#include <QDeclarativeContext>

#include <QtDBus/QtDBus>
#include <QProcess>
#include <QDebug>
#include <QX11Info>
#include <X11/Xlib.h>
#include <X11/extensions/dpms.h>

#include "myinputpanelcontext.h"


class App: public QApplication {
  public:
    App (int argc, char **argv): QApplication(argc, argv) 
    { 
        view = new QDeclarativeView;
        view->setSource(QUrl("launcher.qml"));
        view->show();
        object = view->rootObject();

        screenOn = true;
    }
    bool x11EventFilter(XEvent *event) {
    if (event->type == KeyRelease)
    {
        XKeyEvent * keyEvent = (XKeyEvent *)event;

        qDebug() << keyEvent->keycode;
        if (keyEvent->keycode == 37) //110) // Home
        {
            goHome();
        }
        else if (keyEvent->keycode == 50) //124) // XF86PowerOff
        {
            if (screenOn) {
            QProcess::startDetached("brightness 0");
            DPMSForceLevel(QX11Info::display(), DPMSModeOff);
            }  else {
            QProcess::startDetached("brightness 150");
            }

            screenOn = !screenOn;
            QMetaObject::invokeMethod(object, "lock");
        }
    }
    return QApplication::x11EventFilter(event);
    }

    void goHome() {
        QMetaObject::invokeMethod(object, "gohome");
    }

public:
    QObject *object;
    QDeclarativeView *view;
    bool screenOn;
};

int main(int argc, char **argv)
{
    App app(argc, argv);
    MyInputPanelContext *ic = new MyInputPanelContext;
    app.setInputContext(ic);

    return app.exec();
}
