#include "guiupdater.h"
#include <QDebug>
#include <unistd.h>
#include <string>


using namespace std;


GUIUpdater::GUIUpdater(QObject *parent) : QObject(parent) {
}

void GUIUpdater::updateGUI(QString answerSets) {
    if (mealLabel != NULL) {
        mealLabel->setProperty("text", answerSets);
    }
}
