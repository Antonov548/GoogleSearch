#pragma once

#include <QObject>
#include <QDesktopServices>
#include <QUrl>
#include <QNetworkAccessManager>
#include <QNetworkRequest>
#include <QNetworkReply>
#include <QByteArray>
#include <QXmlStreamReader>
#include <QList>


class GoogleApi : public QObject
{

    Q_OBJECT

    bool firstConnect;

public:
    GoogleApi();
    QNetworkAccessManager *network;


public slots:
    void openUrl(const QString url);
    void requestApi();
    void requestApi(QString str);
    void handleResponse(QNetworkReply* reply);

signals:
    void textChanged(QString);
    void createListView(QList<QString> list);
    void openApplication();

};

