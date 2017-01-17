#include "guiupdater.h"
#include <QDebug>
#include <unistd.h>
#include <string>
#include <QStandardItemModel>
#include <QQmlContext>
#include <mealplan.h>


using namespace std;


GUIUpdater::GUIUpdater(QObject *parent) : QObject(parent) {
}

void GUIUpdater::updateGUI(QString answerSets) {
    if (mealLabel != NULL) {
        mealLabel->setProperty("text", answerSets);
    }
    if (mealViewButton != NULL) {
        mealViewButton->setProperty("visible", true);
        mealViewButton->setProperty("enabled", true);
        mealViewButton->setProperty("text", "View meal plan");
    }
}

void GUIUpdater::makeMealTable(int days, int firstDay) {

    if (mealTable != NULL) {
        qDebug() << "mealTable not null";
        model = new QStandardItemModel(3, days, mealTable);
    //    for (int i = 0; i < days; i++) {
            model->setHorizontalHeaderItem(0, new QStandardItem(QString("Monday")));
     //   }
            QStandardItem *firstRow = new QStandardItem(QString("ColumnValue"));
            model->setItem(0,0,firstRow);
        QQmlContext *context = engine->rootContext();
        context->setContextProperty("contextModel", model);
        //mealTable->setProperty("model", context->contextProperty("contextModel"));
     //   mealTable->setModel(model);
        mealTable->setVisible(true);


    } else {
        qDebug() << "mealTable is null";
    }
}
