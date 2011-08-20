#include <QApplication>
#include <QDeclarativeView>
#include <QDeclarativeEngine>
#include <QDeclarativeContext>

//#include "myinputpanelcontext.h"
#include "pixmapitem.h"
#include "pagemodel.h"

int main(int argc, char **argv)
{
    QApplication app(argc, argv);
    app.setApplicationName("Version/5.0.2 Mobile/8C5101c");

//    MyInputPanelContext *ic = new MyInputPanelContext;
//    app.setInputContext(ic);

    qmlRegisterType<PixmapItem>("MeeTo", 1, 0, "PixmapItem");

    QDeclarativeView *view = new QDeclarativeView;
    view->setSource(QUrl("qrc:/main.qml"));

    PageModel *model = new PageModel();
    model->add(QString(), QString());
    model->add(QString(), QString());

    QDeclarativeContext *context = view->engine()->rootContext();
    context->setContextProperty("tabModel", model);

    view->show();

    return app.exec();
}
