#include <QtGui/QApplication>
#include <QDeclarativeEngine>
#include <QDeclarativeComponent>
#include <QWebSettings>
#include "qmlapplicationviewer.h"
#include "utils.h"
int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    #if defined(Q_OS_LINUX)
        app.setFont(QFont("微软雅黑"));
    #endif


    qmlRegisterType<Utils>("Utils", 1,0, "Utils");
    QWebSettings::globalSettings()->setObjectCacheCapacities(0, 0, 0);
    QWebSettings::globalSettings()->setMaximumPagesInCache(0);
    QmlApplicationViewer viewer;
    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationAuto);
    viewer.setMainQmlFile(QLatin1String("qml/R2/main.qml"));
    viewer.showFullScreen();



    return app.exec();
}
