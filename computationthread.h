#ifndef COMPUTATIONTHREAD_H
#define COMPUTATIONTHREAD_H
#include <QThread>
#include <QObject>


class ComputationThread : public QObject
{
    Q_OBJECT
public:
    ComputationThread();

private:
    QString pathToClingo = "/Applications/clingo-4.5.4-macos-10.9/clingo";
    QString pathToLp = "/Users/martin/Programmierung/ASP/Praktikum/";

signals:
    void resultReady(const QString &str);
    void resultReady(int days, int firstDay);

public slots:
    void launchClingo(int age, int weight, int isFemale, bool vegan, bool lactoseFree, int activity, int days, int startOn);
    void setPaths(QString, QString);
};

#endif // COMPUTATIONTHREAD_H
