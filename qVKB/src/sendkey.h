#ifndef KEYBOARD_H 
#define KEYBOARD_H
 
#include <QObject>
#include <QString>
#include <QDeclarativeView>
#include <QtDBus/QtDBus>

#include <QDebug>
#include <QX11Info>
#include <fakekey/fakekey.h>

class Keyboard : public QObject
{
    Q_OBJECT
public:
    Q_INVOKABLE bool sendKey(const QString &msg) {

    FakeKey *fakekey;
    fakekey = fakekey_init(QX11Info::display());

    QByteArray array = msg.toUtf8();

    if(msg.startsWith(":enter")){
        fakekey_press_keysym(fakekey, XK_Return, 0);
        fakekey_release(fakekey);
        return 0;
    }

    if(msg.startsWith(":hide")){
        QDBusInterface iface("org.xpud.vkb", "/", 
            "local.VkbServer", QDBusConnection::sessionBus());
        if (iface.isValid()) iface.call("toggle");
        return 0;
    }

    if(msg.startsWith(":backspace")){
        fakekey_press_keysym(fakekey, XK_BackSpace, 0);
        fakekey_release(fakekey);
        return 0;
    }
    
    if(msg.startsWith(":eurosign")){
        fakekey_press_keysym(fakekey, XK_EuroSign, 0);
        fakekey_release(fakekey);
        return 0;
    }

    if(msg.startsWith(":sterling")){
        fakekey_press_keysym(fakekey, XK_sterling, 0);
        fakekey_release(fakekey);
        return 0;
    }
    if(msg.startsWith(":yen")){
        fakekey_press_keysym(fakekey, XK_yen, 0);
        fakekey_release(fakekey);
        return 0;
    }

    if(msg.startsWith(":undo")){
        fakekey_press_keysym(fakekey, XK_Undo, 0);
        fakekey_release(fakekey);
        return 0;
    }

    if(msg.startsWith(":redo")){
        fakekey_press_keysym(fakekey, XK_Redo, 0);
        fakekey_release(fakekey);
        return 0;
    }

    for (int i = 0; i < array.length(); i++){
        char u = array.at(i);
        fakekey_press(fakekey, (const unsigned char*)&u, -1, 0);
        fakekey_release(fakekey);
    }

    return 0;
    }

};
 
#endif // KEYBOARD_H 
