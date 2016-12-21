#ifndef MYSLOTS_H
#define MYSLOTS_H

#include <QObject>
#include<string>

class MySlots : public QObject
{
    Q_OBJECT
public:
    explicit MySlots(QObject *parent = 0);

signals:

public slots:
    void launchClingo(int, int);
};

#endif // MYSLOTS_H
