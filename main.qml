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
        signal saveMealPlanButtonClicked()
        signal fileSelected(url fileUrl)

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
                mealPlanTextArea.text = "Preparing your meal plan...\n\nThis may take a while."
                state = "result state"
                saveMealPlanButton.enabled = true
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
                    angryBubbleImage.visible = false
                    floatingHearts.start()

                } else {
                    floatingHearts.complete()
                    angryBubbleImage.visible = true
                    angryBubbleImage.scale = 0.2
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

        backToMainButton {
            onClicked: state = ""
        }

        saveMealPlanButton {
            onClicked: {
                saveMealPlanButtonClicked()
                saveMealPlanButton.enabled = false
                saveMealPlanButton.text = "Saved!"
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
            objectName: "fileDialogue"
            sidebarVisible: true
            title: "Please choose a meal plan to view."
            folder: shortcuts.home
            onAccepted: {
                console.log("You chose: " + fileDialog.fileUrls)
                page.fileSelected(fileDialog.fileUrl)
                page.state = "result state"
                page.saveMealPlanButton.enabled = false
                close()
            }
            onRejected: {
                console.log("Canceled")
                close()
            }
          //  Component.onCompleted: visible = true
        }

        angryBubbleImage {
            Behavior on scale {
                NumberAnimation {
                    from: 0.2
                    to: 1.0
                    duration: 200
                    easing.type: Easing.OutBounce
                }
            }

        }

        heartImage1 {
            id: heart1
         }
        heartImage2 {
            id: heart2
        }
        heartImage3 {
            id: heart3
        }

        ParallelAnimation {
            id: floatingHearts
            loops: 3
            running: true
            PathAnimation {
                path: Path {
                    startX: 100
                    startY: 372
                    PathCurve {relativeX: -10; relativeY: -20}
                    PathCurve {relativeX: 10; relativeY: -20}
                    PathCurve {relativeX: 20; relativeY: -20}
                    PathCurve {relativeX: -10; relativeY: -20}
                }

                target: heart1
                duration: 2000

            }
            NumberAnimation {
                target: heart1
                property: "opacity"
                from: 1
                to: 0
                duration: 2000
                easing.type: Easing.InExpo
            }
            PathAnimation {
                path: Path {
                    startX: 65
                    startY: 342
                    PathCurve {relativeX: -10; relativeY: -20}
                    PathCurve {relativeX: 10; relativeY: -20}
                    PathCurve {relativeX: 20; relativeY: -20}
                    PathCurve {relativeX: -10; relativeY: -20}
                }

                target: heart2
                duration: 1700

            }
            NumberAnimation {
                target: heart2
                property: "opacity"
                from: 1
                to: 0
                duration: 1700
                easing.type: Easing.InExpo
            }
            PathAnimation {
                path: Path {
                    startX: 121
                    startY: 322
                    PathCurve {relativeX: -10; relativeY: -20}
                    PathCurve {relativeX: 10; relativeY: -20}
                    PathCurve {relativeX: 20; relativeY: -20}
                    PathCurve {relativeX: -10; relativeY: -20}
                }

                target: heart3
                duration: 2500

            }
            NumberAnimation {
                target: heart3
                property: "opacity"
                from: 1
                to: 0
                duration: 2500
                easing.type: Easing.InExpo
            }
        }

    } 
}
