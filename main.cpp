#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QDebug>
#include <guiupdater.h>
#include <computationthread.h>
#include <QTableWidget>


int main(int argc, char *argv[])
{
    qDebug() << QT_VERSION_STR;
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    QObject *object = engine.rootObjects().first();
    QObject *main = object->findChild<QObject*>("main");

    GUIUpdater updater;
    ComputationThread compThread;

    QObject::connect(main, SIGNAL(computationButtonClickedSignal(int,int,int,bool,bool,int,int,int)), &compThread, SLOT(launchClingo(int,int,int,bool,bool,int,int,int)));
    QObject::connect(main, SIGNAL(pathsSignal(QString, QString)), &compThread, SLOT(setPaths(QString, QString)));
    QObject::connect(&compThread, SIGNAL(resultReady(QString)), &updater, SLOT(updateGUI(QString)));
    QObject::connect(&compThread, SIGNAL(resultReady(int,int)), &updater, SLOT(makeMealTable(int,int)));
    updater.mealLabel = main->findChild<QObject*>("mealPlan");
    updater.mealViewButton = main->findChild<QObject*>("mealViewButton");
    updater.mealTable = main->findChild<QTableWidget*>("mealPlanTable");
    updater.engine = &engine;


    QThread thread;

    thread.start();
    compThread.moveToThread(&thread);
    updater.mealLabel->setProperty("text", "Preparing your meal plan...\n\nThis may take a while.");
    return app.exec();
}
