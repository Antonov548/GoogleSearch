#include "trayicon.h"

TrayIcon::TrayIcon(QObject *parent):QObject(parent)
{
    trayIcon = new QSystemTrayIcon();
    trayIcon->setIcon(QIcon(":/icon/search(trayIcon).ico"));
    trayIcon->setToolTip("Show");
    trayIcon->show();

    connect(trayIcon,SIGNAL(activated(QSystemTrayIcon::ActivationReason)),this,SLOT(trayIconClicked(QSystemTrayIcon::ActivationReason)));

}


void TrayIcon::trayIconClicked(QSystemTrayIcon::ActivationReason reason){

    switch (reason){

    case QSystemTrayIcon::Context:
        emit signalShowMenu(trayIcon->geometry().x(),trayIcon->geometry().y());
        break;
    case QSystemTrayIcon::Trigger:
        emit signalShow();
        break;
    default:
        break;

    }

}

void TrayIcon::closeApp()
{
    trayIcon->hide();
}
