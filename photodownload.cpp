#include "photodownload.h"

PhotoDownload::PhotoDownload(QObject *parent) :
    QObject(parent)
{
    http = new QNetworkAccessManager(parent);
    connect(http,SIGNAL(finished(QNetworkReply*)),this,SLOT(finished(QNetworkReply*)));
    connect(&saveTask,SIGNAL(saveDone(QString)),this,SLOT(rmvHistory(QString)));
}


void PhotoDownload::setPath(QString dir)
{
    saveTask.setPath(dir);
}

void PhotoDownload::download(QUrl url)
{
    if(!history.contains(url.toString()))
    {
        qDebug()<<"start download image"<<url;
        history.append(url.toString());
        QNetworkRequest request(url);
        request.setRawHeader("User-Agent","Mozilla/5.0 (X11; U; Linux i686; en-US) AppleWebKit/534.10 (KHTML, like Gecko) Chrome/8.0.552.215 Safari/534.10");
        request.setRawHeader("Keep-Alive","115");
        request.setRawHeader("Referer","http://www.google.com");
        http->get(request);
    }


}

void PhotoDownload::rmvHistory(const QString &url)
{
    history.removeOne(url);
}

void PhotoDownload::finished(QNetworkReply *reply)
{
    saveTask.append(reply);

}

PhotoDownload::~PhotoDownload()
{
    delete http;
}



