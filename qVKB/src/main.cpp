#include <QApplication>
#include <QtDBus/QtDBus>
#include "vkbserver.h"

int main(int argc, char *argv[]) {

    QApplication app(argc, argv);

    if (!QDBusConnection::sessionBus().isConnected()) return 1;
    if (!QDBusConnection::sessionBus().registerService("org.xpud.vkb")) exit(1);

    VkbServer vkb;
    QDBusConnection::sessionBus().registerObject("/", &vkb, QDBusConnection::ExportAllSlots);

    return app.exec();
}
