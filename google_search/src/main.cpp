#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QDebug>
#include <QIcon>

#include <trayicon.h>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QGuiApplication::setAttribute(Qt::AA_DisableHighDpiScaling);

    app.setWindowIcon(QIcon(":/icon/search(trayIcon).ico"));

    TrayIcon trayIcon;

    QQmlApplicationEngine engine;

    engine.rootContext()->setContextProperty("trayIcon",&trayIcon);

    engine.load(QUrl(QStringLiteral("qrc:/qml/main.qml")));
    engine.load(QUrl(QStringLiteral("qrc:/qml/traymenu.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
