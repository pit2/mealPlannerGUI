#include "myslots.h"
#include <QDebug>
#include <unistd.h>
#include <string>

using namespace std;

#define NUM_PIPES          2

#define PARENT_WRITE_PIPE  0
#define PARENT_READ_PIPE   1

int pipes[NUM_PIPES][2];

/* pipe[0] is for read and pipe[1] is for write */
#define READ_FD  0
#define WRITE_FD 1

#define PARENT_READ_FD  ( pipes[PARENT_READ_PIPE][READ_FD]   )
//#define PARENT_WRITE_FD ( pipes[PARENT_WRITE_PIPE][WRITE_FD] )

//#define CHILD_READ_FD   ( pipes[PARENT_WRITE_PIPE][READ_FD]  )
#define CHILD_WRITE_FD  ( pipes[PARENT_READ_PIPE][WRITE_FD]  )

MySlots::MySlots(QObject *parent) : QObject(parent) {
}

MySlots::~MySlots() {
    qDebug() << "MySlots destroyed";
}

void MySlots::launchClingo(int age, int weight, int isFemale, bool vegan, bool lactoseFree, int activity) {

        qDebug() << "Launching clingo!";
        pid_t processId;

         // pipes for parent to write and read
         pipe(pipes[PARENT_READ_PIPE]);
        // pipe(pipes[PARENT_WRITE_PIPE]);

        if ((processId = fork()) == 0) {


        //    dup2(CHILD_READ_FD, STDIN_FILENO);
            dup2(CHILD_WRITE_FD, STDOUT_FILENO);

            /* Close fds not required by child. Also, we don't
                     want the exec'ed program to know these existed */
        //    close(CHILD_READ_FD);
            close(CHILD_WRITE_FD);
            close(PARENT_READ_FD);
         //   close(PARENT_WRITE_FD);

            string sex = isFemale == 0 ? "male" : "female";
            string habits = vegan ? "vegan" : "normal";
            string lactIntolerance = lactoseFree ? "true" : "false";
            char * app = pathToClingo.toLocal8Bit().data();//"/Applications/clingo-4.5.4-macos-10.9/clingo";
            char * const argv[] = { app, (char*)"1", (pathToLp + "nutritionFacts16_mod.lp").toLocal8Bit().data(),
                                    (pathToLp + "dailyDose.lp").toLocal8Bit().data(),
                                    (pathToLp + "mealsPerDay.lp").toLocal8Bit().data(),
                                    (pathToLp + "categories_mod.lp").toLocal8Bit().data(),
                                    (char*)(("-c age = " + to_string(age)).c_str()),
                                    (char*)(("-c weight = " + to_string(weight)).c_str()),
                                    (char*)(("-c sex = " + sex).c_str()),
                                    (char*)(("-c habits = " + habits).c_str()),
                                    (char*)(("-c lactIntolerance = " + lactIntolerance).c_str()),
                                    (char*)(("-c pal = " + to_string(activity)).c_str()), NULL };


            if (execv(app, argv) < 0) {
                perror("execv error");
            }
        } else if (processId < 0) {
            perror("fork error");
        } else {
            char buffer[100];
            int count;

            /* close fds not required by parent */
        //    close(CHILD_READ_FD);
            close(CHILD_WRITE_FD);

            // Write to child’s stdin
        //    write(PARENT_WRITE_FD, "2^32\n", 5);

            // Read from child’s stdout
            count = read(PARENT_READ_FD, buffer, sizeof(buffer)-1);
            if (count >= 0) {
                buffer[count] = 0;
                qDebug() << "Redirecting child stdout: " << buffer ;
                if (mealLabel != NULL) {
                    mealLabel->setProperty("text", buffer);
                }
                m_answerSets = buffer;
            } else {
                qDebug() << "IO Error\n";
            }
        }
}

void MySlots::setPaths(QString clingoPath, QString lpPath) {
    pathToClingo = clingoPath;
    pathToLp = lpPath;
}
