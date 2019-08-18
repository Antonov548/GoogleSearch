#include <google_api.h>

const QString GoogleApi::mg_search_url = "http://google.com/complete/search?output=toolbar&q=%1";

GoogleApi::GoogleApi()
{
    connect(&m_network, &QNetworkAccessManager::finished, [this](auto reply)
    {
        if(reply->error() == QNetworkReply::NoError)
        {
            emit handleResponse(reply->readAll());
        }
        else
        {
            emit httpError();
        }
    });
}

void GoogleApi::get(QString text)
{
    m_network.get(QNetworkRequest(QUrl(mg_search_url.arg(text))));
}
