import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Dialogs 1.2

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("Food Planner")

    menuBar: MenuBar {
        Menu {
            title: qsTr("File")
            MenuItem {
                text: qsTr("&Open")
                onTriggered: console.log("Open action triggered");
            }
            MenuItem {
                text: qsTr("Exit")
                onTriggered: Qt.quit();
            }
        }
    }

    MainForm {
        anchors.fill: parent
        id: page

        ageSlider {
            updateValueWhileDragging: true
        }

        age {
            text: ageSlider.value
        }

        weightSlider {
            updateValueWhileDragging: true
        }

        weight {
            text: weightSlider.value
        }



        startComputationButton {
            onClicked: console.log(startComputationButton.text + " clicked")
        }
    }

 /*   StateGroup {
              id: stateGroup
              states: [
                  State {
                      name: "State1"

                      PropertyChanges {
                          target: page.icon
                          x: page.middleRightRect.x
                          y: page.middleRightRect.y
                      }
                  },
                  State {
                      name: "State2"

                      PropertyChanges {
                          target: page.icon
                          x: page.bottomLeftRect.x
                          y: page.bottomLeftRect.y
                      }
                  }
              ]




              transitions: [
                  Transition {
                      from: "*"; to: "State1"
                      NumberAnimation {
                          easing.type: Easing.OutBounce
                          properties: "x,y";
                          duration: 1000
                      }
                  },

                  Transition {
                      from: "*"; to: "State2"
                      NumberAnimation {
                          properties: "x,y";
                          easing.type: Easing.InOutQuad;
                          duration: 2000
                      }
                  },

                  Transition {
                      NumberAnimation {
                          properties: "x,y";
                          duration: 200
                      }
                  }
              ]


    }*/
}
