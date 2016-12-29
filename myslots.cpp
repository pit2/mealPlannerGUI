#include "myslots.h"
#include <QDebug>
#include <unistd.h>
#include <string>
#include <QQmlApplicationEngine>

using namespace std;

MySlots::MySlots(QObject *parent) : QObject(parent) {
}

MySlots::~MySlots() {
    qDebug() << "MySlots destroyed";
}

void MySlots::launchClingo(int age, int weight, int isFemale, bool vegan, bool lactoseFree, int activity) {

        qDebug() << "Launching clingo!";
        pid_t processId;

        if ((processId = fork()) == 0) {
            string sex = isFemale == 0 ? "male" : "female";
            string habits = vegan ? "vegan" : "normal";
            string lactIntolerance = lactoseFree ? "true" : "false";
            // /Users/martin/Programmierung/ASP/Praktikum/
            char * app = pathToClingo.toLocal8Bit().data();//"/Applications/clingo-4.5.4-macos-10.9/clingo";
            char * const argv[] = { app, (char*)"0", (pathToLp + "nutritionFacts.lp").toLocal8Bit().data(),
                                    (pathToLp + "dailyDose.lp").toLocal8Bit().data(),
                                    (pathToLp + "mealsPerDay.lp").toLocal8Bit().data(),
                                    (char*)(("-c age = " + to_string(age)).c_str()),
                                    (char*)(("-c weight = " + to_string(weight)).c_str()),
                                    (char*)(("-c sex = " + sex).c_str()),
                                    (char*)(("-c habits = " + habits).c_str()),
                                    (char*)(("-c lactIntolerance = " + lactIntolerance).c_str()),
                                    (char*)(("-c pal = " + to_string(activity)).c_str()), NULL };
            if (execv(app, argv) < 0) {
                perror("execv error");
            }
        } else if (processId < 0) {
            perror("fork error");
        }
}

void MySlots::setPaths(QString clingoPath, QString lpPath) {
    pathToClingo = clingoPath;
    pathToLp = lpPath;
}
