TEMPLATE = app
TARGET = qtouchweb 

QT += webkit declarative opengl
DEFINES += USE_OPENGL=1
CONFIGS += release

HEADERS +=  pixmapitem.h\
            pagemodel.h

#           myinputpanelcontext.h
SOURCES +=  main.cpp\
            pixmapitem.cpp\
            pagemodel.cpp
#           myinputpanelcontext.cpp

RESOURCES = resource.qrc
