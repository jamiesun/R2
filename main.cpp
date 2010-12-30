#include <QtGui/QApplication>
#include <QDeclarativeEngine>
#include <QDeclarativeComponent>
#include <QWebSettings>
#include "qmlapplicationviewer.h"
#include "utils.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    qmlRegisterType<Utils>("Utils", 1,0, "Utils");
    QWebSettings::globalSettings()->setObjectCacheCapacities(128*1024, 4*1024*1024, 4*1024*1024);
    QWebSettings::globalSettings()->setMaximumPagesInCache(10);
    QString path("E://.R2//");
    QWebSettings::globalSettings()->setLocalStoragePath(path);
    QWebSettings::globalSettings()->setOfflineStoragePath(path);
    QmlApplicationViewer viewer;
    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationAuto);
    viewer.setMainQmlFile(QLatin1String("qml/R2/main.qml"));
    viewer.showFullScreen();

    return app.exec();
}
