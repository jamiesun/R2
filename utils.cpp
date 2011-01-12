#include "utils.h"
#include <QFile>
#include <QTextStream>
#include <QDataStream>
#include <QDateTime>
#include <QDebug>
#include <QtGui/QApplication>
#include <QCryptographicHash>
#include <QWebSettings>
Utils::Utils(QObject *parent) : QThread(parent),changed(false)
{
    imagePath = getPath()+"images/";
    QDir dir(imagePath);
    if(!dir.exists(imagePath))
    {
        dir.mkdir(imagePath);
    }
    downTask.setPath(imagePath);

    if(QFile::exists(getPath()+".cache"))
    {
        QFile file(getPath()+".cache");
        file.open(QIODevice::ReadOnly);
        QDataStream in(&file);
        in.setVersion(QDataStream::Qt_4_7);
        in>>cache;
        file.close();
    }
    this->start();

}



void  Utils::write(const QString &fname, const QString &ctx)
{
    QFile file(getPath()+fname);
    file.open(QIODevice::WriteOnly | QIODevice::Text);
    QTextStream out(&file);
    out << ctx.toUtf8();
    file.close();
}


QString Utils::read(const QString &fname)
{
    if(!QFile::exists(getPath()+fname))
    {
        return "";
    }
    QFile file(getPath()+fname);
    file.open(QIODevice::ReadOnly | QIODevice::Text);
    return QString::fromUtf8(file.readAll());
}

QString Utils::safeRead(const QString &fname)
{
    if(!QFile::exists(getPath()+fname))
    {
        return "";
    }

    QFile file(getPath()+fname);
    file.open(QIODevice::ReadOnly | QIODevice::Text);
    QString result = QString::fromUtf8(file.readAll());

    int len = result.length();
    for(int i=0;i<len;++i)
    {
       result[i] = QChar::fromAscii(result[i].toAscii() + 1);
    }

    return result;

}

void Utils::safeWrite(const QString &fname, const QString &ctx)
{
    QString dest = ctx;
    int len = dest.length();
    for(int i=0;i<len;++i)
    {
       dest[i] = QChar::fromAscii(dest[i].toAscii() - 1);
    }

    QFile file(getPath()+fname);
    file.open(QIODevice::WriteOnly | QIODevice::Text);
    QTextStream out(&file);
    out << dest.toUtf8();
    file.close();
}

void Utils::showMouse(bool isShow)
{
    if(isShow)
    {
        QApplication::setNavigationMode(Qt::NavigationModeCursorForceVisible);
    }
    else
    {
        QApplication::setNavigationMode(Qt::NavigationModeKeypadDirectional);
    }
}

void Utils::syncCache()
{
    if(!changed)
        return;
    QMutexLocker locker(&lock);
    qDebug()<<"sync cache";
    QFile file(getPath()+".cache");
    file.open(QIODevice::WriteOnly);
    QDataStream out(&file);
    out.setVersion(QDataStream::Qt_4_7);
    out<<cache;
    file.flush();
    file.close();
}

QString Utils::getCache(const QString &name)
{
    return cache[name];
}


void Utils::setCache(const QString &key,const QString &value)
{
    cache[key] = value;
    changed = true;
}

void Utils::clearWebCache()
{
    QWebSettings::globalSettings()->clearMemoryCaches();
}

QString Utils::getPath()
{
    QString path;
#if defined(Q_OS_SYMBIAN)
    path = QString("E:/.R2/");
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

void Utils::addUrl(const QString &url)
{
    downTask.download(QUrl(url));
}

QString Utils::getImagePath(const QString &url)
{
    QByteArray fid  = QCryptographicHash::hash ( url.toAscii(),QCryptographicHash::Md5 );
    QString ipath;
    ipath.append(imagePath).append(fid.toHex());

    if(QFile::exists(ipath))
    {
        return "file:///"+ipath;
    }
    else
    {
        addUrl(url);
        return url;
    }
}


void Utils::run()
{
    while(true)
    {
        sleep(60);
        syncCache();
    }
}


