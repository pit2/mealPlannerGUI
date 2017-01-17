#include "mealplan.h"
#include <QDebug>
#include <QString>

MealPlan::MealPlan(string str, int numberOfDays)
{
    int current = 0;
    int lower, higher;
    string day, food;
    lower = str.find("breakfast", current); // find a "breakfast" line
    lower = str.find("\"", lower + 1); // proceed to first " (encapsulating the weekday)
    higher = str.find("\"", lower + 1); // find second "
    day = str.substr(lower + 1, higher - lower - 1); // extract weekday
    lower = str.find(",", lower + 2); // proceed to , as the food item is listed after the ,
    higher = str.find(")", lower); // find closing )
    food = str.substr(lower + 1, higher - lower - 1);
    qDebug() << "identified day as: " << QString::fromStdString(day);
    qDebug() << "found food: " << QString::fromStdString(food);


}
