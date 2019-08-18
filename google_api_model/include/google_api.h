#pragma once

#include <QObject>
#include <QUrl>
#include <QNetworkAccessManager>
#include <QNetworkRequest>
#include <QNetworkReply>
#include <QByteArray>
#include <QXmlStreamReader>
#include <QList>
#include <google_api_export.h>

class GOOGLE_API_EXPORT GoogleApi : public QObject
{
    Q_OBJECT

public:
    GoogleApi();
    ~GoogleApi() = default;

signals:
    void handleResponse(QByteArray data);
    void httpError();

public slots:
    void get(QString text);

private:
    static const QString mg_search_url;
    QNetworkAccessManager m_network;
};
