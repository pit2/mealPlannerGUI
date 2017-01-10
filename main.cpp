#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QDebug>
#include <guiupdater.h>
#include <computationthread.h>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    QObject *object = engine.rootObjects().first();
    QObject *main = object->findChild<QObject*>("main");

    GUIUpdater updater;
    ComputationThread compThread;

    QObject::connect(main, SIGNAL(computationButtonClickedSignal(int,int,int,bool,bool,int)), &compThread, SLOT(launchClingo(int,int,int,bool,bool,int)));
    QObject::connect(main, SIGNAL(pathsSignal(QString, QString)), &compThread, SLOT(setPaths(QString, QString)));
    QObject::connect(&compThread, SIGNAL(resultReady(QString)), &updater, SLOT(updateGUI(QString)));
    updater.mealLabel = main->findChild<QObject*>("mealPlan");

    QThread thread;

    thread.start();
    compThread.moveToThread(&thread);
    updater.mealLabel->setProperty("text", "Preparing your meal plan...\n\nThis may take a while.");
    return app.exec();
}
