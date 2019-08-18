#pragma once

#include <QObject>
#include <QSystemTrayIcon>
#include <QString>
#include <QMenu>
#include <QAction>
#include <tray_icon_export.h>

class TRAY_ICON_EXPORT TrayIcon : public QObject
{
    Q_OBJECT

public:
    explicit TrayIcon(QString tool_tip, QString icon_file, QObject *parent = nullptr);
    ~TrayIcon();

public slots:
    void trayIconClicked(QSystemTrayIcon::ActivationReason reason);
    void show();
    void hide();

signals:
    void clicked(int x, int y);
    void doubleClicked(int x, int y);
    void triggered(int x, int y);

private:
    QSystemTrayIcon* m_tray_icon;
};
