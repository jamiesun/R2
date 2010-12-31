#ifndef UTILS_H
#define UTILS_H

#include <QObject>
#include <QFSFileEngine>
#include <QDir>

class Utils : public QObject
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
    Q_INVOKABLE void showMouse(bool isShow);
signals:

public slots:

private:
    QString getPath()
    {
        QString path;
    #if defined(Q_OS_SYMBIAN)
        path = QString("E://.R2//");
    #else
        path = QFSFileEngine::homePath()+"/.R2/";
    #endif
        QDir dir(path);
        if(!dir.exists(path))
        {
            dir.mkdir(path);
        }
        return path;
    }

};

#endif // UTILS_H
