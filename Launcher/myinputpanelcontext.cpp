#include <QtCore>
#include <QtDBus/QtDBus>
#include "myinputpanelcontext.h"

MyInputPanelContext::MyInputPanelContext()
{
//    inputPanel = new MyInputPanel;
//    connect(inputPanel, SIGNAL(characterGenerated(QChar)), SLOT(sendCharacter(QChar)));
}


MyInputPanelContext::~MyInputPanelContext()
{
//     delete inputPanel;
}

bool MyInputPanelContext::filterEvent(const QEvent* event)
{

    if (event->type() == QEvent::CloseSoftwareInputPanel) {
        QDBusInterface iface("org.xpud.vkb", "/", 
            "local.VkbServer", QDBusConnection::sessionBus());
        if (iface.isValid()) iface.call("focusout");
    }

    if (event->type() == QEvent::RequestSoftwareInputPanel) {
        qDebug() << "QEvent::RequestSoftwareInputPanel";
        QDBusInterface iface("org.xpud.vkb", "/", 
            "local.VkbServer", QDBusConnection::sessionBus());
        if (iface.isValid()) iface.call("focusin");
    }

     return false;
}


QString MyInputPanelContext::identifierName()
{
     return "MyInputPanelContext";
}

void MyInputPanelContext::reset()
{
}

bool MyInputPanelContext::isComposing() const
{
    return false;
}

QString MyInputPanelContext::language()
{
    return "en_US";
}


/*
void MyInputPanelContext::sendCharacter(QChar character)
{
    QPointer<QWidget> w = focusWidget();

     if (!w)
         return;

     QKeyEvent keyPress(QEvent::KeyPress, character.unicode(), Qt::NoModifier, QString(character));
     QApplication::sendEvent(w, &keyPress);

     if (!w)
         return;

     QKeyEvent keyRelease(QEvent::KeyPress, character.unicode(), Qt::NoModifier, QString());
     QApplication::sendEvent(w, &keyRelease);
 }



 void MyInputPanelContext::updatePosition()
 {
     QWidget *widget = focusWidget();
     if (!widget)
         return;

     QRect widgetRect = widget->rect();
     QPoint panelPos = QPoint(widgetRect.left(), widgetRect.bottom() + 2);
     panelPos = widget->mapToGlobal(panelPos);
     inputPanel->move(panelPos);
 }
*/
