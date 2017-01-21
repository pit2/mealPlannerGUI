#ifndef COMPUTATIONTHREAD_H
#define COMPUTATIONTHREAD_H
#include <QThread>
#include <QObject>

using namespace std;

class ComputationThread : public QObject
{
    Q_OBJECT
public:
    ComputationThread();
    QString getPathToClingo();
    QString getPathToLp();

private:
    QString pathToClingo;
    QString pathToLp;

signals:
    void resultReady(const QString &str, int days);
    void resultReady(const QString &answerSets, int days, int firstDay);

public slots:
    void launchClingo(int age, int weight, int isFemale, bool vegan, bool lactoseFree, int activity, int days, int startOn);
    void setPaths(QString, QString);
};

#endif // COMPUTATIONTHREAD_H
