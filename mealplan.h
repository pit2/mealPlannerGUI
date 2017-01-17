#ifndef MEALPLAN_H
#define MEALPLAN_H

#include <string>

using namespace std;

class MealPlan
{
public:
    MealPlan(string str, int numberOfDays);

private:
    int startDay = 0;
    int numOfDays = 1;
    //static string days[] = {"Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"};
    //string breakfast[];
    //string lunch[];
    //string dinner[];

};

#endif // MEALPLAN_H
