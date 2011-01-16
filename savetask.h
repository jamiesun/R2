#ifndef SAVETASK_H
#define SAVETASK_H
#include <QNetworkReply>
#include <QMutex>
#include <QQueue>
#include <QThread>
class SaveTask:public QThread
{
    Q_OBJECT
public:
    explicit SaveTask(QObject *parent = 0);
    void append(QNetworkReply* reply);
    void setPath(QString dir);

signals:
    void saveDone(const QString &url);
    void saveFail(const QString &url);

public slots:

protected:
    void run();

private:
    QQueue<QNetworkReply*> saveQueue;
    QMutex lock;
    QString dir;
};
#endif // SAVETASK_H
