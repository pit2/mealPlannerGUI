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

        onStateChanged: {
            if (state != "waiting state") {
                food1.visible = false
                food2.visible = false
                food3.visible = false
                food4.visible = false
                food5.visible = false
                food6.visible = false
                food7.visible = false
            }
            if (state == "result state") {
                saveMealPlanButton.enabled = true
            }
        }

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
            onClicked: {
                mealPlanTextArea.text = "Preparing your meal plan...\n\nThis may take a while."
                state = "waiting state"
                bouncingFood1.start()
                //saveMealPlanButton.enabled = true
                angryBubbleImage.visible = false
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
        }

        angryBubbleImage {
            Behavior on scale {
                NumberAnimation {
                    from: 0.2
                    to: 1.0
                    duration: 200
                    easing.type: Easing.OutBounce
                    onStarted: {
                        heart1.visible = false
                        heart2.visible = false
                        heart3.visible = false
                        floatingHearts.stop()
                    }
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
            alwaysRunToEnd: false
            onStarted: {
                heart1.visible = true
                heart2.visible = true
                heart3.visible = true
            }

            onStopped: {
                heart1.visible = false
                heart2.visible = false
                heart3.visible = false
            }

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

        Image {
            id: food1
            visible: false
            source: "banana64.png"
            width: 32
            height: 32
            x: 0
            y: 350
        }
        Image {
            id: food2
            visible: false
            source: "apple64.png"
            width: 32
            height: 32
            x: 640
            y: 350
        }
        Image {
            id: food3
            visible: false
            source: "burger64.png"
            width: 32
            height: 32
            x: 0
            y: 350
        }
        Image {
            id: food4
            visible: false
            source: "cookie64.png"
            width: 32
            height: 32
            x: 640
            y: 350
        }
        Image {
            id: food5
            visible: false
            source: "pie64.png"
            width: 32
            height: 32
            x: 0
            y: 350
        }
        Image {
            id: food6
            visible: false
            source: "soda64.png"
            width: 32
            height: 32
            x: 640
            y: 350
        }
        Image {
            id: food7
            visible: false
            source: "strawberry64.png"
            width: 32
            height: 32
            x: 0
            y: 350
        }

        Path {
            id: bounceFromLeft
            startX: 0
            startY: 350
            PathArc {radiusX: 30; radiusY: 40; relativeX: 60; relativeY: 0}
            PathArc {radiusX: 30; radiusY: 40; relativeX: 60; relativeY: 0}
            PathArc {radiusX: 30; radiusY: 40; relativeX: 60; relativeY: 0}
            PathArc {radiusX: 30; radiusY: 40; relativeX: 60; relativeY: 0}
            PathArc {radiusX: 30; radiusY: 60; relativeX: 60; relativeY: -10}
        }

        Path {
            id: bounceFromRight
            startX: 640
            startY: 350
            PathArc {direction: PathArc.Counterclockwise; radiusX: 30; radiusY: 40; relativeX: -60; relativeY: 0}
            PathArc {direction: PathArc.Counterclockwise; radiusX: 30; radiusY: 40; relativeX: -60; relativeY: 0}
            PathArc {direction: PathArc.Counterclockwise; radiusX: 30; radiusY: 40; relativeX: -60; relativeY: 0}
            PathArc {direction: PathArc.Counterclockwise; radiusX: 30; radiusY: 40; relativeX: -60; relativeY: 0}
            PathArc {direction: PathArc.Counterclockwise; radiusX: 30; radiusY: 60; relativeX: -80; relativeY: -10}
        }

        SequentialAnimation {
            id: bouncingFood1
            onStarted: {
                food1.opacity = 1
                food1.visible = true
            }
            onStopped: {
                if (page.state == "waiting state") {
                    food2.visible = true
                    food2.opacity = true
                    bouncingFood2.start()
                }
            }

            PathAnimation {
                target: food1
                duration: 1000
                path: bounceFromLeft
            }
            NumberAnimation {
                target: food1
                property: "opacity"
                from: 1
                to: 0
                duration: 250
            }

        }
        SequentialAnimation {
            id: bouncingFood2
            onStopped: {
                if (page.state == "waiting state") {
                    food3.visible = true
                    food3.opacity = true
                    bouncingFood3.start()
                }
            }

            PathAnimation {
                target: food2
                duration: 1000
                path: bounceFromRight
            }
            NumberAnimation {
                target: food2
                property: "opacity"
                from: 1
                to: 0
                duration: 250
            }
        }
        SequentialAnimation {
            id: bouncingFood3
            onStopped: {
                if (page.state == "waiting state") {
                    food4.visible = true
                    food4.opacity = true
                    bouncingFood4.start()
                }
            }
            PathAnimation {
                target: food3
                duration: 1000
                path: bounceFromLeft
            }
            NumberAnimation {
                target: food3
                property: "opacity"
                from: 1
                to: 0
                duration: 250
            }
        }
        SequentialAnimation {
            id: bouncingFood4
            onStopped: {
                if (page.state == "waiting state") {
                    food5.visible = true
                    food5.opacity = true
                    bouncingFood5.start()
                }
            }
            PathAnimation {
                target: food4
                duration: 1000
                path: bounceFromRight
            }
            NumberAnimation {
                target: food4
                property: "opacity"
                from: 1
                to: 0
                duration: 250
            }
        }
        SequentialAnimation {
            id: bouncingFood5
            onStopped: {
                if (page.state == "waiting state") {
                    food6.visible = true
                    food6.opacity = true
                    bouncingFood6.start()
                }
            }
            PathAnimation {
                target: food5
                duration: 1000
                path: bounceFromLeft
            }
            NumberAnimation {
                target: food5
                property: "opacity"
                from: 1
                to: 0
                duration: 250
            }
        }
        SequentialAnimation {
            id: bouncingFood6
            onStopped: {
                if (page.state == "waiting state") {
                    food7.visible = true
                    food7.opacity = true
                    bouncingFood7.start()
                }
            }
            PathAnimation {
                target: food6
                duration: 1000
                path: bounceFromRight
            }
            NumberAnimation {
                target: food6
                property: "opacity"
                from: 1
                to: 0
                duration: 250
            }
        }
        SequentialAnimation {
            id: bouncingFood7
            onStopped: {
                if (page.state == "waiting state") {
                    food1.visible = true
                    food1.opacity = true
                    bouncingFood1.start()
                }
            }
            PathAnimation {
                target: food7
                duration: 1000
                path: bounceFromLeft
            }
            NumberAnimation {
                target: food7
                property: "opacity"
                from: 1
                to: 0
                duration: 250
            }
        }

    } 
}
