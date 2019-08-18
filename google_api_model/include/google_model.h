#pragma once

#include <QStringListModel>
#include <QList>
#include <google_api.h>
#include <google_api_export.h>

class GOOGLE_API_EXPORT GoogleModel : public QStringListModel
{
    Q_OBJECT

    Q_PROPERTY(GoogleApi* api READ api WRITE setApi NOTIFY apiChanged)

public:
    GoogleModel(GoogleApi* api = nullptr);
    ~GoogleModel() = default;

    GoogleApi* api() const;

public slots:
    void setApi(GoogleApi* api);
    QString getDataByIndex(int index);

signals:
    void apiChanged(GoogleApi* api);

private slots:
    void updateList(QByteArray data);

private:
    GoogleApi* m_api;

    void reconnectApiToModel(GoogleApi* new_api);
};
