#ifndef GUIUPDATER_H
#define GUIUPDATER_H

#include <QObject>
#include <string>
#include <QQmlApplicationEngine>
#include <QStandardItemModel>
#include <QTableWidget>


class GUIUpdater : public QObject
{
    Q_OBJECT
public:
    explicit GUIUpdater(QObject *parent = 0);
    QQmlApplicationEngine *engine;
    QObject *mealLabel;
    QObject *mealViewButton;
    QTableWidget *mealTable;

private:
    QStandardItemModel *model;

public slots:
    void updateGUI(QString);
    void makeMealTable(int, int);

};

#endif // GUIUPDATER_H
