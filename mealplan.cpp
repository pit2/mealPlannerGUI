#include "mealplan.h"
#include <QDebug>
#include <QString>
#include <map>

MealPlan::MealPlan(string str, int numberOfDays)
{
    qDebug() << "Called constructor for mealPlan";
    multimap<string,string>::iterator it;
    map<string,multimap<string,string>>::iterator it2;

    weeklyPlan = new multimap<string,multimap<string,string>>();
    int index = 0;
    index = findMealsFor(str, "breakfast", index, weeklyPlan);
    index = findMealsFor(str, "lunch", index, weeklyPlan);
    findMealsFor(str, "dinner", index, weeklyPlan);

    // DEBUG Output
    for (it2=weeklyPlan->begin(); it2!=weeklyPlan->end(); ++it2) {
        qDebug() << "On " << QString::fromStdString((*it2).first);
        for (it = (*it2).second.begin(); it != (*it2).second.end(); ++it) {
            qDebug() << "eat for " << QString::fromStdString((*it).first) << " " << QString::fromStdString((*it).second);
        }
    }
}

int MealPlan::findMealsFor(string str, string time, int startIndex, multimap<string,multimap<string,string>> *weeklyPlan) {
    int lower = startIndex;
    int higher = lower;
    string day, prevDay, food;
    multimap<string,string> partialPlan;
    multimap<string,string>::iterator it = partialPlan.begin();
    while(true) {

        lower = str.find(time, lower); // find e.g. a "breakfast" line
        if (lower == string::npos) { // no more meals for current time slot (across all days)
            weeklyPlan->insert(pair<string,multimap<string,string>>(prevDay, partialPlan));
            break;
        }
        lower = str.find("\"", lower + 1); // proceed to first " (encapsulating the weekday)
        higher = str.find("\"", lower + 1); // find second "
        day = str.substr(lower + 1, higher - lower - 1); // extract weekday
        if (!prevDay.empty() && prevDay != day) { // add partial plan (e.g. breakfast on a given day) to weeklyPlan
            qDebug() << "Inserting into weeklyPlan on day " << QString::fromStdString(prevDay);
            weeklyPlan->insert(pair<string,multimap<string,string>>(prevDay, partialPlan));
            partialPlan.clear();
            it = partialPlan.begin();
        }
       // qDebug() << "day is " << QString::fromStdString(day);
       // qDebug() << "prevDay is " << QString::fromStdString(prevDay);
        prevDay = day;
        lower = str.find(",", lower + 2); // proceed to , as the food item is listed after the ,
        higher = str.find(")", lower); // find closing )
        food = str.substr(lower + 1, higher - lower - 1);
        it = partialPlan.insert(it, pair<string,string>(time, food));

    }

    qDebug() << "iterating from within findMealsFor";

  /*  multimap<string,string>::iterator it3;
    map<string,multimap<string,string>>::iterator it2;
    for (it2=weeklyPlan->begin(); it2 != weeklyPlan->end(); ++it2) {
        qDebug() << "On " << QString::fromStdString((*it2).first);
        for (it3 = (*it2).second.begin(); it3 != (*it2).second.end(); ++it3) {
            qDebug() << "eat for " << QString::fromStdString((*it3).first) << " " << QString::fromStdString((*it3).second);
        }

    } */

    return higher;
}
