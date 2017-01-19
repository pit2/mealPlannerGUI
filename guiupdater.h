#ifndef GUIUPDATER_H
#define GUIUPDATER_H

#include <QObject>
#include <string>
#include <QQmlApplicationEngine>
#include <QStandardItemModel>
#include <QTableView>
#include <mealplan.h>


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
    void reformatOutput();


private:
    QStandardItemModel *model;

public slots:
    void updateGUI(QString, int);
    void makeMealTable(QString answerSets, int, int);

};

#endif // GUIUPDATER_H
