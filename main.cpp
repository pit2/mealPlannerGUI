#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlComponent>
#include <QQmlProperty>
#include <QDebug>
#include <myslots.h>


int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    QQmlComponent component(&engine, "main.qml");
    QObject *object = engine.rootObjects().first();
    QObject *main = object->findChild<QObject*>("main");
    QObject *ageSlider = object->findChild<QObject*>("ageSlider");
    QObject *startButton = object->findChild<QObject*>("startButton");

    MySlots mySlots;
    QObject::connect(main, SIGNAL(buttonClickedSignal(int,int)), &mySlots, SLOT(launchClingo(int,int)));
    return app.exec();
}
