TEMPLATE = app
TARGET = qtouchweb 

QT += webkit declarative

HEADERS += mainwindow.h \
           scrollbar.h \
           pagemodel.h \
           pixmapitem.h \
           kineticscroll.h \
           mobilewebview.h \
           mobilewebpage.h

SOURCES += main.cpp \
           mainwindow.cpp \
           scrollbar.cpp \
           pagemodel.cpp \
           pixmapitem.cpp \
           kineticscroll.cpp \
           mobilewebview.cpp \
           mobilewebpage.cpp

!isEmpty(USE_OPENGL) {
    QT += opengl
    DEFINES += USE_OPENGL=1
}

isEmpty(RESOLUTION) {
    RESOLUTION = "1024x600"
}

RESOURCES = ../resource/$$RESOLUTION/resource.qrc
