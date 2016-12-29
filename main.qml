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

        signal computationButtonClickedSignal(int age, int weight, int female, bool vegan, bool lactoseFree, int activity)
        signal pathsSignal(string pathToCLingo, string pathToLp)

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

        activitySlider {
            updateValueWhileDragging: true
            onValueChanged: {
                if (activitySlider.value == 1) {
                    activity.text = "Rooted Tree"
                } else if (activitySlider.value == 2) {
                    activity.text = "Couch Potato"
                } else if (activitySlider.value == 3) {
                    activity.text = "Minor Activity"
                } else if (activitySlider.value == 4) {
                    activity.text = "Some Walking"
                } else if (activitySlider.value == 5) {
                    activity.text = "Physically Active"
                } else if (activitySlider.value == 6) {
                    activity.text = "Hercules"
                }
            }
        }

        startComputationButton {
            onClicked: {
                console.log(startComputationButton.text + " clicked")
                computationButtonClickedSignal(ageSlider.value, weightSlider.value, genderBox.currentIndex,
                                               veganCheckbox.checked, lactoseCheckBox.checked, activitySlider.value)
            }
        }

        configButton {
            onClicked: {
                state = "config state"
            }
        }

        veganCheckbox {
            onCheckedChanged: {
                if  (veganCheckbox.checked) {
                    lactoseCheckBox.checked = true
                }
            }
        }

        lactoseCheckBox {
            onCheckedChanged: {
                if (!lactoseCheckBox.checked) {
                    veganCheckbox.checked = false
                }
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

        genderBox {
            model: ["male", "female"]
        }


    } 
}
