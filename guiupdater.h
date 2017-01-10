#ifndef GUIUPDATER_H
#define GUIUPDATER_H

#include <QObject>
#include<string>

class GUIUpdater : public QObject
{
    Q_OBJECT
public:
    explicit GUIUpdater(QObject *parent = 0);
    QObject *mealLabel;

public slots:
    void updateGUI(QString);

};

#endif // GUIUPDATER_H
