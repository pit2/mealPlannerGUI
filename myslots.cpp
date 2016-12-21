#include "myslots.h"
#include <QDebug>
#include <unistd.h>
#include <string>

using namespace std;

MySlots::MySlots(QObject *parent) : QObject(parent) {
}

void MySlots::launchClingo(int age, int weight) {

        qDebug() << "Launching clingo!";
        pid_t processId;

        if ((processId = fork()) == 0) {
            char app[] = "/Applications/clingo-4.5.4-macos-10.9/clingo";
            string pathToLP = "/users/martin/Programmierung/ASP/Praktikum/";
            char * const argv[] = { app, (char*)"0", (char*)(pathToLP + "nutritionFacts.lp").c_str(),
                                    (char*)("/users/martin/Programmierung/ASP/Praktikum/dailyDose.lp"),
                                    (char*)("/users/martin/Programmierung/ASP/Praktikum/mealsPerDay.lp"),
                                    (char*)(("-c age = " + to_string(age)).c_str()),
                                    (char*)(("-c weight = " + to_string(weight)).c_str()), NULL };
            if (execv(app, argv) < 0) {
                perror("execv error");
            }
        } else if (processId < 0) {
            perror("fork error");
        }
}
