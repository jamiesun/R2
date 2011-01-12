#ifndef PHOTODOWNLOAD_H
#define PHOTODOWNLOAD_H
#include <QObject>
#include <QNetworkAccessManager>
#include <QUrl>
#include <QNetworkRequest>
#include <QNetworkReply>
#include <QStringList>
#include <QDebug>
#include <savetask.h>
class PhotoDownload :public QObject
{
    Q_OBJECT
public:
    explicit PhotoDownload(QObject *parent = 0);
    ~PhotoDownload();
    void setPath(QString dir);
    void download(QUrl url);
signals:

public slots:
    void finished(QNetworkReply* reply);
    void rmvHistory(const QString &url);

private:
    QNetworkAccessManager *http;
    SaveTask saveTask;
    QStringList history;
};



#endif // PHOTODOWNLOAD_H
