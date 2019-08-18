#include <google_model.h>
#include <QDebug>

GoogleModel::GoogleModel(GoogleApi* api) :
    m_api(nullptr)
{
    reconnectApiToModel(api);
}

GoogleApi *GoogleModel::api() const
{
    return m_api;
}

void GoogleModel::setApi(GoogleApi *api)
{
    if (m_api == api)
        return;

    reconnectApiToModel(api);
    emit apiChanged(m_api);
}

void GoogleModel::updateList(QByteArray data)
{
    qDebug() << "work";
    if (data.isEmpty())
    {
        return;
    }
    QStringList list;
    QXmlStreamReader xml(data);

    while (!xml.atEnd())
    {
        xml.readNext();
        if(xml.tokenType() == QXmlStreamReader::StartElement)
            if (xml.name() == "suggestion"){
                QString dataStr = xml.attributes().value("data").toString();
                list.append(dataStr);
            }
    }
    setStringList(list);
}

QString GoogleModel::getDataByIndex(int index)
{
    auto list = stringList();
    if (index < 0 || index > list.count() - 1)
        return QString();
    return list[index];
}

void GoogleModel::reconnectApiToModel(GoogleApi* new_api)
{
    if (m_api)
    {
        disconnect(m_api);
    }

    if (new_api)
    {
        connect(new_api, &GoogleApi::handleResponse, this, &GoogleModel::updateList);
    }
    m_api = new_api;
}
