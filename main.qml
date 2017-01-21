import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.2
import QtQuick.Controls.Styles 1.4

ApplicationWindow {
    id: root
    visible: true
    width: 640
    height: 480
    title: qsTr("Meal Planner")

    MainForm {
        anchors.fill: parent
        id: page
        objectName: "main"
        state: "base state"

        signal computationButtonClickedSignal(int age, int weight, int female, bool vegan, bool lactoseFree, int activity, int days, int startOn)
        signal pathsSignal(string pathToCLingo, string pathToLp)
        signal mealViewButtonClicked()
        signal settingsButtonClicked()

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
            iconSource: "cauldron.png"
           /* style: ButtonStyle {
                background: Rectangle {
                    border.width: 0
                    implicitHeight: 128
                    implicitWidth: 128
                    color: "transparent"
                }

            }*/
            onClicked: {
                console.log("COmputation button clicked")
                state = "result state"
                computationButtonClickedSignal(ageSlider.value, weightSlider.value, genderBox.currentIndex,
                                               veganCheckbox.checked, lactoseCheckBox.checked, activitySlider.value,
                                               dayBox.currentText, startOnBox.currentIndex)

            }
            isDefault: true
        }

        configButton {

            iconSource: "settingsIcon32.png"
            style: ButtonStyle {
                background: Rectangle {
                    border.width: 0
                    implicitHeight: 32
                    implicitWidth: 32
                    color: "transparent"
                }

            }

            onClicked: {
                state = "config state"
                settingsButtonClicked()
            }
        }

        clingoPathInput {
            objectName: "clingoPathInput"
        }

        lpPathInput {
            objectName: "lpPathInput"
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
            isDefault: true
        }

        genderBox {
            model: ["male", "female"]
        }

        dayBox {
            model: [1, 2, 3, 4, 5, 6, 7]
        }

        startOnBox {
            model: ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
        }

        mealPlanTextArea {
            objectName: "mealPlan"
            readOnly: true
        }

        mealViewButton {
            objectName: "mealViewButton"
            visible: false
            enabled: false
            onClicked: {
                mealViewButtonClicked()
                state = "mealPlan state"
                mealPlanTable.anchors.fill = resultRectangle
                mealPlanTable.visible = true
                mealPlanTable.enabled = true
            }
        }

        ListModel {
            id: tableData
            ListElement {
                time: "Breakfast"
                monday: "Banana, Cereal, Apples, Coffee, Bagel, Donuts, Toast Hawai"
                tuesday: "Orange"
            }

            ListElement {
                time: "Lunch"
                monday: "Steak"
            }

            ListElement {
                time: "Dinner"
            }
        }

        TableView  {
            id: mealPlanTable
            objectName: "mealPlanTable"
            //parent: resultRectangle
            model: tableData
            visible: false
            enabled: false

       //     onMealsGot: {

         //   }

            TableViewColumn {
                title: "Time"
                role: "time"
            }

            TableViewColumn {
                title: "Monday"
                role: "monday"

            }
            TableViewColumn {
                title: "Tuesday"
                role: "tuesday"
            }
            TableViewColumn {
                title: "Wednesday"
            }
            TableViewColumn {
                title: "Thursday"
            }
            TableViewColumn {
                title: "Friday"
            }
            TableViewColumn {
                title: "Saturday"
            }
            TableViewColumn {
                title: "Sunday"
            }
        }

        loadButton {
            iconSource: "fileLoadIcon32.png"
            style: ButtonStyle {
                background: Rectangle {
                    border.width: 0
                    implicitHeight: 32
                    implicitWidth: 32
                    color: "transparent"
                }
            }
            onClicked: fileDialog.open()
        }

        FileDialog {
            id: fileDialog
            sidebarVisible: true
            title: "Please choose a meal plan to view."
            folder: shortcuts.home
            onAccepted: {
                console.log("You chose: " + fileDialog.fileUrls)
                close()
            }
            onRejected: {
                console.log("Canceled")
                close()
            }
          //  Component.onCompleted: visible = true
        }
    } 
}
