#include <QGuiApplication>
#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QDebug>
#include <QIcon>

#include "trayicon.h"
#include "googleapi.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    QApplication::setAttribute(Qt::AA_DisableHighDpiScaling);

    app.setWindowIcon(QIcon(":/icon/search(trayIcon).ico"));

    TrayIcon trayIcon;

    GoogleApi googleApi;

    QQmlApplicationEngine engine;

    engine.rootContext()->setContextProperty("trayIcon",&trayIcon);
    engine.rootContext()->setContextProperty("googleApi",&googleApi);

    engine.load(QUrl(QStringLiteral("qrc:/qml/main.qml")));
    engine.load(QUrl(QStringLiteral("qrc:/qml/traymenu.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
