#ifndef MEALPLAN_H
#define MEALPLAN_H

#include <string>
#include <map>

using namespace std;

class MealPlan
{
public:
    MealPlan(string str, int numberOfDays);
    string toString();


private:
    int startDay = 0;
    int numOfDays = 1;
    const string days[7] = {"Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"};
    multimap<string, multimap<string,string>> *weeklyPlan; // key is a weekday, value the meal plan (whose key is the time (e.g. breakfast) and the food items

    static int findMealsFor(string str, string time, int startIndex, multimap<string, multimap<string, string> > *weeklyPlan);
    pair<multimap<string,multimap<string,string>>::iterator,multimap<string,multimap<string,string>>::iterator>  rangeOnDay(string day);

};

#endif // MEALPLAN_H
