#ifndef PHOTODOWNLOAD_H
#define PHOTODOWNLOAD_H
#include <QObject>
#include <QNetworkAccessManager>
#include <QUrl>
#include <QNetworkRequest>
#include <QNetworkReply>


class PhotoDownload :public QObject
{
    Q_OBJECT
public:
    explicit PhotoDownload(QObject *parent = 0);
    ~PhotoDownload();
    void setPath(QString dir);
    QString getPath();
    void download(QUrl url);

signals:

public slots:
    void finished(QNetworkReply* reply);

private:
    QNetworkAccessManager *http;
    QString dir;
};

#endif // PHOTODOWNLOAD_H