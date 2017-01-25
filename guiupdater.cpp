#include "guiupdater.h"
#include <QDebug>
#include <unistd.h>
#include <string>
#include <QQmlContext>
#include <mealplan.h>
#include <QTableView>
#include <QFile>
#include <QDataStream>
#include <QDir>
#include <QUrl>
#include <QDateTime>
using namespace std;


GUIUpdater::GUIUpdater(QObject *parent) : QObject(parent) {
}

void GUIUpdater::updateGUI(QString answerSets, int days) {
    main->setProperty("state", "result state");
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

void GUIUpdater::writeMealPlanToFile() {
    QString name = QDateTime::currentDateTime().toString();
    QDir dir = QDir::home();
    QFile file(dir.filePath(name + ".mp"));
    if (!file.open(QIODevice::WriteOnly)) {
        qDebug() << "Could not create file!";
    }
    QDataStream toFile(&file);
    toFile << QString::fromStdString(mealPlan->toString());
    file.close();
}

void GUIUpdater::readMealPlanFromFile(QUrl url) {
    QFile file(url.toLocalFile());
    if (!file.open(QIODevice::ReadOnly)) {
        qDebug() << "Failed to read file";
    }
    QDataStream fromFile(&file);
    QString str;
    fromFile >> str;
    mealLabel->setProperty("text", str);
}

void GUIUpdater::updatePaths() {
    pathToClingoLabel->setProperty("text", compThread->getPathToClingo());
    pathToLpLabel->setProperty("text", compThread->getPathToLp());
}
