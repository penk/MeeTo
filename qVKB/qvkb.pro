TEMPLATE = app
TARGET = qvkb 

QT += declarative dbus

HEADERS +=  src/sendkey.h \ 
            src/vkbserver.h \
            src/mainwindow.h

SOURCES +=  src/main.cpp \
            src/mainwindow.cpp

RESOURCES = resource/resource.qrc

LIBS += -lfakekey
