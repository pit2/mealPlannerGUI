import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.2


ApplicationWindow {
    id: root
    visible: true
    width: 640
    height: 480
    title: qsTr("Food Planner")

    MainForm {
        anchors.fill: parent
        id: page
        objectName: "main"
        state: "base state"


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

        signal computationButtonClickedSignal(int age, int weight)
        signal pathsSignal(string pathToCLingo, string pathToLp)


        startComputationButton {
            onClicked: {
                console.log(startComputationButton.text + " clicked")
                computationButtonClickedSignal(ageSlider.value, weightSlider.value)
            }
            objectName: "startButton"
        }

        configButton {
            onClicked: {
                state = "config state"
            }
        }

        saveButton {
            onClicked: {
                if (page.state == "config state") {
                    console.log("Clicked save button - path is: " + clingoPathInput.text)
                    page.state = ""
                    pathsSignal(clingoPathInput.text, lpPathInput.text)
                }

            }
        }
    } 
}
