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
        objectName: "main"

        ageSlider {
            updateValueWhileDragging: true
            objectName: "age"
        }

        age {
            text: ageSlider.value
        }

        weightSlider {
            updateValueWhileDragging: true
            objectName: "weight"
        }

        weight {
            text: weightSlider.value
        }

        signal buttonClickedSignal(int age, int weight)

        startComputationButton {
            onClicked: { console.log(startComputationButton.text + " clicked")
                            buttonClickedSignal(ageSlider.value, weightSlider.value) }
            objectName: "startButton"
        }
    } 
}
