#ifndef UTILS_H
#define UTILS_H

#include <QObject>
#include <QFSFileEngine>
#include <QDir>
#include <QMap>
#include <QVariant>
#include <QThread>
#include <QMutex>
#include <QMutexLocker>
#include <QWebSettings>
#include <photodownload.h>
class Utils :public QThread
{
    Q_OBJECT
public:
    explicit Utils(QObject *parent = 0);
    Q_INVOKABLE QString read(const QString &fname);
    Q_INVOKABLE void write(const QString &fname,const QString &ctx);
    Q_INVOKABLE QString safeRead(const QString &fname);
    Q_INVOKABLE void safeWrite(const QString &fname,const QString &ctx);
    Q_INVOKABLE QString getCache(const QString &key);
    Q_INVOKABLE void setCache(const QString  &key,const QString &value);
    Q_INVOKABLE void syncCache();
    Q_INVOKABLE void showMouse(bool isShow);
    Q_INVOKABLE QString getPath();
    Q_INVOKABLE QString getImagePath(const QString &url);
    Q_INVOKABLE void addUrl(const QString &url);
    Q_INVOKABLE void clearWebCache();
signals:

public slots:

protected:
    void run();

private:
    QMap<QString,QString> cache;
    bool changed;
    PhotoDownload downTask;
    QString imagePath;
    QMutex lock;


};

#endif // UTILS_H
