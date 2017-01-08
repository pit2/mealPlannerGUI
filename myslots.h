#ifndef MYSLOTS_H
#define MYSLOTS_H

#include <QObject>
#include<string>

class MySlots : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString answerSets READ answerSets WRITE setAnswerSets NOTIFY answerSetsChanged)
public:
    explicit MySlots(QObject *parent = 0);
    ~MySlots();
    void setAnswerSets(const QString answerSets) { m_answerSets = answerSets; }
    QString answerSets() const { return m_answerSets; }
    QObject *mealLabel;




private:
    QString pathToClingo = "/Applications/clingo-4.5.4-macos-10.9/clingo";
    QString pathToLp = "/Users/martin/Programmierung/ASP/Praktikum/";
    QString m_answerSets = "No answer set computed yet.";


signals:
    void answerSetsChanged();

public slots:
    void launchClingo(int, int, int, bool, bool, int);
    void setPaths(QString, QString);

};

#endif // MYSLOTS_H
