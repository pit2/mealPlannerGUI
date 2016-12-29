#ifndef MYSLOTS_H
#define MYSLOTS_H

#include <QObject>
#include<string>
#include"configslots.h"

class MySlots : public QObject
{
    Q_OBJECT
public:
    explicit MySlots(QObject *parent = 0);
    ~MySlots();
    ConfigSlots *configSlots;

private:
    QString pathToClingo = "/Applications/clingo-4.5.4-macos-10.9/clingo";
    QString pathToLp;


signals:

public slots:
    void launchClingo(int, int);
    void setPaths(QString, QString);

};

#endif // MYSLOTS_H
