#ifndef GUIUPDATER_H
#define GUIUPDATER_H

#include <QObject>
#include <string>
#include <QQmlApplicationEngine>
#include <QStandardItemModel>
#include <QTableView>
#include <mealplan.h>
#include <computationthread.h>

class GUIUpdater : public QObject
{
    Q_OBJECT
public:
    explicit GUIUpdater(QObject *parent = 0);
    QQmlApplicationEngine *engine;
    QObject *mealLabel;
    QObject *mealViewButton;
    QObject *mealTable;
    MealPlan *mealPlan;
    QObject *pathToClingoLabel;
    QObject *pathToLpLabel;
    ComputationThread *compThread;

    void reformatOutput();


private:
    QStandardItemModel *model;

public slots:
    void updateGUI(QString, int);
    void makeMealTable(QString answerSets, int, int);
    void updatePaths();

};

#endif // GUIUPDATER_H
