#include <savetask.h>
#include <QDebug>
#include <QImageReader>
#include <QImage>
#include <QCryptographicHash>
SaveTask::SaveTask(QObject *parent) : QThread(parent)
{
   this->start();
}

void SaveTask::append(QNetworkReply *reply)
{
    lock.lock();
    saveQueue.append(reply);
    lock.unlock();
}

void SaveTask::setPath(QString dir)
{
    this->dir = dir;
}

void SaveTask::run()
{
    while(true){
        while (saveQueue.isEmpty()) {
            sleep(10);
        }
        lock.lock();
        QNetworkReply *reply = saveQueue.dequeue();
        lock.unlock();
        QVariant statusCodeV = reply->attribute(QNetworkRequest::HttpStatusCodeAttribute);
        if (statusCodeV.toInt()==200)
        {
           QString fname;
           QImageReader imageReader(reply);
           QImage pic = imageReader.read();
           QByteArray fid  = QCryptographicHash::hash ( reply->url().toString().toAscii(),
                                               QCryptographicHash::Md5 );
           fname =  QString(dir+"%1").arg(QString(fid.toHex()));
           if(pic.size().width()>300)
           {
               QImage thumb = pic.scaledToWidth(300,Qt::SmoothTransformation);
               thumb.save(fname,"JPG");
           }
           else
           {
               pic.save(fname,"JPG");
           }
           qDebug()<<fname<<" download ok";
           emit saveDone(reply->url().toString());
        }
        else
        {
           qDebug()<<" download error:"<<reply->errorString();
        }

        reply->deleteLater();
    }
}
