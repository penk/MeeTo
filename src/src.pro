TEMPLATE = app
TARGET = raskbrowser

QT += webkit declarative

HEADERS += mainwindow.h \
           scrollbar.h \
           pagemodel.h \
           kineticscroll.h \
           mobilewebview.h \
           mobilewebpage.h

SOURCES += main.cpp \
           mainwindow.cpp \
           scrollbar.cpp \
           pagemodel.cpp \
           kineticscroll.cpp \
           mobilewebview.cpp \
           mobilewebpage.cpp

!isEmpty(USE_OPENGL) {
    QT += opengl
    DEFINES += USE_OPENGL=1
}

isEmpty(RESOLUTION) {
    RESOLUTION = "800x480"
}

RESOURCES = ../resource/$$RESOLUTION/resource.qrc
