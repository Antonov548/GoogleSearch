#include <trayicon.h>

TrayIcon::TrayIcon(QString tool_tip, QString icon_file, QObject *parent) : QObject(parent)
{
    m_tray_icon = new QSystemTrayIcon();
    m_tray_icon->setIcon(QIcon(icon_file));
    m_tray_icon->setToolTip(tool_tip);

    connect(m_tray_icon, &QSystemTrayIcon::activated, this, &TrayIcon::trayIconClicked);
}

TrayIcon::~TrayIcon()
{
    delete m_tray_icon;
}

void TrayIcon::trayIconClicked(QSystemTrayIcon::ActivationReason reason)
{
    switch (reason)
    {
        case QSystemTrayIcon::Context:
            emit triggered(m_tray_icon->geometry().x(), m_tray_icon->geometry().y());
            break;
        case QSystemTrayIcon::Trigger:
            emit clicked(m_tray_icon->geometry().x(), m_tray_icon->geometry().y());
            break;
        case QSystemTrayIcon::DoubleClick:
            emit doubleClicked(m_tray_icon->geometry().x(), m_tray_icon->geometry().y());
            break;
        default:
            break;
    }
}

void TrayIcon::show()
{
    m_tray_icon->show();
}

void TrayIcon::hide()
{
    m_tray_icon->hide();
}
