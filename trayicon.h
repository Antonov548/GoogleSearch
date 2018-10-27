#pragma once

#include <QObject>
#include <QSystemTrayIcon>
#include <QMenu>
#include <QAction>

class TrayIcon : public QObject
{
    Q_OBJECT

public:
    explicit TrayIcon(QObject *parent = nullptr);

private:
    QSystemTrayIcon *trayIcon;


public slots:
    void trayIconClicked(QSystemTrayIcon::ActivationReason reason);
    void closeApp();

signals:
    void signalShow();
    void signalShowMenu(int _x,int _y);
};
