#include <QtGui>
#include "photodownload.h"
#include <QDebug>
#include <QImageReader>
#include <QImage>
#include <QCryptographicHash>
PhotoDownload::PhotoDownload(QObject *parent) :
    QObject(parent)
{
    http = new QNetworkAccessManager(parent);
    connect(http,SIGNAL(finished(QNetworkReply*)),this,SLOT(finished(QNetworkReply*)));
}


void PhotoDownload::setPath(QString dir)
{
    this->dir = dir;
}

void PhotoDownload::download(QUrl url)
{
    http->get(QNetworkRequest(url));

}

QString PhotoDownload::getPath()
{
    return this->dir;
}

void PhotoDownload::finished(QNetworkReply *reply)
{
    QVariant statusCodeV =
       reply->attribute(QNetworkRequest::HttpStatusCodeAttribute);
       if (statusCodeV.toInt()==200)
       {
           QString fname;
           QImageReader imageReader(reply);
           QImage pic = imageReader.read();
           QByteArray fid  = QCryptographicHash::hash ( reply->url().toString().toAscii(),
                                               QCryptographicHash::Md5 );
           fname =  QString(dir+"%1").arg(QString(fid.toHex()));
           pic.save(fname,"PNG");
           qDebug()<<fname<<" download ok";
       }
       else
       {
           qDebug()<<" download error:"<<reply->errorString();
       }
}

PhotoDownload::~PhotoDownload()
{
    delete http;
}
