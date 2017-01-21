#include "guiupdater.h"
#include <QDebug>
#include <unistd.h>
#include <string>
#include <QQmlContext>
#include <mealplan.h>
#include <QTableView>


using namespace std;


GUIUpdater::GUIUpdater(QObject *parent) : QObject(parent) {
}

void GUIUpdater::updateGUI(QString answerSets, int days) {
    if (mealLabel != NULL) {
     //   mealLabel->setProperty("text", answerSets);
        mealPlan = new MealPlan(answerSets.toStdString(), days);
        QString str = QString::fromStdString(mealPlan->toString());
        mealLabel->setProperty("text", str);
    }
    if (mealViewButton != NULL) {
        mealViewButton->setProperty("visible", false);
        mealViewButton->setProperty("enabled", false);
        mealViewButton->setProperty("text", "View meal plan");
    }
}

void GUIUpdater::makeMealTable(QString answerSets, int days, int firstDay) {
   // mealPlan = new MealPlan(answerSets.toStdString(), days);
   // mealPlan->toString();
    if (mealTable != NULL) {
      //  QTableView *table = (QTableView*) mealTable;
        qDebug() << "mealTable not null";
       // MealPlan model = new MealPlan(answerSets.toStdString(), days);
    //    for (int i = 0; i < days; i++) {
     //       model->setHorizontalHeaderItem(0, new QStandardItem(QString("Monday")));
     //   }
            QStandardItem *firstRow = new QStandardItem(QString("ColumnValue"));
         //   model->setItem(0,0,firstRow);
        QQmlContext *context = engine->rootContext();
      //  context->setContextProperty("contextModel", model);
      //  mealTable->setProperty("model", context->contextProperty("contextModel"));
    //    table->setModel(mealPlan);

    } else {
        qDebug() << "mealTable is null";
    }
}

void GUIUpdater::reformatOutput() {

}

void GUIUpdater::updatePaths() {
    pathToClingoLabel->setProperty("text", compThread->getPathToClingo());
    pathToLpLabel->setProperty("text", compThread->getPathToLp());
}
