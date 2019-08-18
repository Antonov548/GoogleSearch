#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QDirIterator>
#include <QDebug>
#include <QIcon>

#include <trayicon.h>
#include <google_api.h>
#include <google_model.h>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QGuiApplication::setAttribute(Qt::AA_DisableHighDpiScaling);

    app.setWindowIcon(QIcon(":/res/icon/search(trayIcon).ico"));

    TrayIcon trayIcon("Show", ":/res/icon/search(trayIcon).ico");
    trayIcon.show();

    GoogleApi googleApi;

    qmlRegisterType<GoogleModel>("GModel", 1, 0, "GoogleModel");

    QQmlApplicationEngine engine;

    engine.rootContext()->setContextProperty("trayIcon", &trayIcon);
    engine.rootContext()->setContextProperty("googleApi", &googleApi);

    engine.load(QUrl(QStringLiteral("qrc:/qml/main.qml")));
    engine.load(QUrl(QStringLiteral("qrc:/qml/TrayMenu.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
