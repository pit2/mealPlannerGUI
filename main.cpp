#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QDebug>
#include <myslots.h>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    QObject *object = engine.rootObjects().first();
    QObject *main = object->findChild<QObject*>("main");

    MySlots mySlots;
    QObject::connect(main, SIGNAL(computationButtonClickedSignal(int,int,int,bool,bool,int)), &mySlots, SLOT(launchClingo(int,int,int,bool,bool,int)));
    QObject::connect(main, SIGNAL(pathsSignal(QString, QString)), &mySlots, SLOT(setPaths(QString, QString)));
    mySlots.mealLabel = main->findChild<QObject*>("mealPlan");

    return app.exec();
}
