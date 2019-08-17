#include "googleapi.h"

#include <QDebug>

const QString googleSearchUrl = "http://www.google.com/search?q=%1";

const QString googleApiUrl = "http://google.com/complete/search?output=toolbar&q=%1";

GoogleApi::GoogleApi()
{
    firstConnect = false;

    network = new QNetworkAccessManager();
    requestApi();

    connect(this,SIGNAL(textChanged(QString)),this,SLOT(requestApi(QString)));
    connect(network,SIGNAL(finished(QNetworkReply*)),this,SLOT(handleResponse(QNetworkReply*)));

}

void GoogleApi::openUrl(const QString url){
    QDesktopServices::openUrl(QUrl(googleSearchUrl.arg(url)));
}

void GoogleApi::requestApi(){
    network->get(QNetworkRequest(QUrl(googleApiUrl.arg("test"))));
    firstConnect = true;
}

void GoogleApi::requestApi(QString str){
    network->get(QNetworkRequest(QUrl(googleApiUrl.arg(str))));
}

void GoogleApi::handleResponse(QNetworkReply *reply){
    if(firstConnect){
        firstConnect = false;
        emit openApplication();
    }
    else
        if(reply->error() == QNetworkReply::NoError){

            QList<QString> list;
            QByteArray response (reply->readAll());
            QXmlStreamReader xml(response);

            while (!xml.atEnd()) {
                xml.readNext();
                if(xml.tokenType() == QXmlStreamReader::StartElement)
                    if (xml.name() == "suggestion"){
                        QString dataStr = xml.attributes().value("data").toString();
                        list.append(dataStr);
                    }
            }
            emit createListView(list);
        }
    reply->deleteLater();
}


