import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.2

Item {
    id: page
    width: 640
    height: 480
    property alias mealPlanTextArea: mealPlanTextArea
    property alias configButton: configButton
    property alias activity: activity
    property alias activitySlider: activitySlider
    property alias lactoseCheckBox: lactoseCheckBox
    property alias genderBox: genderBox
    property alias lpPathInput: lpPathInput
    property alias clingoPathInput: clingoPathInput
    property alias saveButton: saveButton
    property alias weight: weight
    property alias weightLabel: weightLabel
    property alias weightSlider: weightSlider
    property alias age: age
    property alias ageSlider: ageSlider
    property alias ageLabel: ageLabel
    property alias rect: rect
    property alias startComputationButton: startComputationButton
    property alias veganCheckbox: veganCheckbox

    Text {
        id: title
        x: 216
        width: 106
        height: 15
        color: "#0f6226"
        text: qsTr("MEAL PLANNER")
        anchors.horizontalCenterOffset: -59
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 0
        font.capitalization: Font.AllUppercase
        font.bold: true
        font.pixelSize: 26
    }

    Button {
        id: startComputationButton
        x: 464
        y: 334
        width: 128
        height: 128
        text: qsTr("")
        anchors.horizontalCenterOffset: 0
        activeFocusOnPress: true
        isDefault: false
        tooltip: "Compute a meal plan using the current settings."
        checkable: true
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 18
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Rectangle {
        id: rect
        width: 600
        height: 250
        color: "#ffffff"
        z: -1
        anchors.left: parent.left
        anchors.leftMargin: 18
        anchors.top: parent.top
        anchors.topMargin: 60

        Slider {
            id: ageSlider
            x: 10
            y: 61
            width: 548
            height: 22
            tickmarksEnabled: false
            stepSize: 1
            updateValueWhileDragging: true
            minimumValue: 3
            value: 20
            maximumValue: 120

            Label {
                id: ageLabel
                x: 0
                y: -22
                text: qsTr("Age: ")
            }

            Label {
                id: age
                x: 37
                y: -22
                text: qsTr("20")
            }
        }

        Slider {
            id: weightSlider
            x: 10
            y: 114
            width: 548
            height: 22
            maximumValue: 200
            value: 80
            Label {
                id: weightLabel
                x: 0
                y: -22
                text: qsTr("Weight (kg): ")
            }

            Label {
                id: weight
                x: 83
                y: -22
                text: qsTr("20")
            }
            stepSize: 1
            minimumValue: 5
            updateValueWhileDragging: true
            tickmarksEnabled: false
        }

        CheckBox {
            id: veganCheckbox
            x: 92
            y: 105
            text: qsTr("vegan")
            anchors.top: parent.top
            anchors.topMargin: 10
            anchors.left: parent.left
            anchors.leftMargin: 161
            activeFocusOnPress: false
            checked: true
        }

        ComboBox {
            id: genderBox
            x: 8
            y: 10
            height: 20
        }

        CheckBox {
            id: lactoseCheckBox
            x: 245
            y: 10
            text: qsTr("lactose-free meals")
            checked: true
        }

        Slider {
            id: activitySlider
            x: 10
            y: 169
            width: 548
            height: 22
            stepSize: 1
            updateValueWhileDragging: true
            maximumValue: 6
            value: 2
            tickmarksEnabled: true
            Label {
                id: activityLabel
                x: 0
                y: -22
                text: qsTr("Activity level:")
            }

            Label {
                id: activity
                x: 83
                y: -22
                width: 160
                text: qsTr("Couch Potato")
            }
            minimumValue: 1
        }
    }

    Rectangle {
        id: blurRectangle
        x: 83
        y: 334
        width: 200
        height: 200
        color: "#ffffff"
        opacity: 0
    }

    Rectangle {
        id: settingsPopup
        x: -6
        y: -9
        color: "#bcb0b0"
        visible: false
        Button {
            id: saveButton
            x: 292
            y: 352
            text: qsTr("Save")
            anchors.bottom: parent.bottom
            anchors.rightMargin: 8
            anchors.bottomMargin: 8
            anchors.right: parent.right
        }

        Label {
            id: clingoPathLabel
            text: qsTr("Enter path to Clingo:")
            anchors.top: parent.top
            anchors.topMargin: 17
            TextField {
                id: clingoPathInput
                width: 350
                height: 23
                text: qsTr("Path/To/ClingoApp")
                anchors.top: parent.top
                anchors.topMargin: 22
                anchors.leftMargin: 0
                anchors.left: parent.left
            }
            anchors.leftMargin: 18
            anchors.left: parent.left
        }

        Label {
            id: lpPathLabel
            x: -5
            y: -2
            text: qsTr("Enter path to Clingo:")
            anchors.top: parent.top
            anchors.topMargin: 17
            TextField {
                id: lpPathInput
                width: 350
                height: 23
                text: qsTr("Path/To/ClingoApp")
                anchors.top: parent.top
                anchors.topMargin: 22
                anchors.leftMargin: 0
                anchors.left: parent.left
            }
            anchors.leftMargin: 18
            anchors.left: parent.left
        }
        border.width: 5
        border.color: "#020202"
        anchors.fill: parent
    }

    Rectangle {
        id: resultRectangle
        x: 8
        y: 60
        width: 200
        height: 200
        color: "#ffffff"
        visible: false
        opacity: 0

        TextArea {
            id: mealPlanTextArea
            anchors.fill: parent
        }
    }

    Button {
        id: configButton
        x: 586
        width: 32
        height: 32
        text: ""
        anchors.right: parent.right
        anchors.rightMargin: 22
        anchors.top: parent.top
        anchors.topMargin: 22
        iconSource: "nil"
        activeFocusOnPress: true
        opacity: 1
        isDefault: true
    }
    states: [
        State {
            name: "config state"

            PropertyChanges {
                target: startComputationButton
                enabled: false
            }

            PropertyChanges {
                target: blurRectangle
                x: 0
                y: 60
                width: 640
                height: 420
                opacity: 0.7
            }

            PropertyChanges {
                target: settingsPopup
                visible: true
                anchors.leftMargin: 51
                anchors.topMargin: 172
                anchors.rightMargin: 51
                anchors.bottomMargin: 172
            }

            PropertyChanges {
                target: lpPathLabel
                text: qsTr("Enter path to *.lp files:")
                anchors.topMargin: 69
                anchors.leftMargin: 18
            }

            PropertyChanges {
                target: lpPathInput
                text: qsTr("/Users/martin/Programmierung/ASP/Praktikum/")
            }

            PropertyChanges {
                target: clingoPathInput
                text: qsTr("/Applications/clingo-4.5.4-macos-10.9/clingo")
            }

            PropertyChanges {
                target: configButton
                visible: false
            }
        },
        State {
            name: "result state"

            PropertyChanges {
                target: startComputationButton
                y: 429
                text: qsTr("Show me food!")
                visible: false
                anchors.bottomMargin: 25
                anchors.horizontalCenterOffset: 6
            }

            PropertyChanges {
                target: lpPathInput
                text: qsTr("Path/To/ClingoApp")
            }

            PropertyChanges {
                target: rect
                visible: false
            }

            PropertyChanges {
                target: resultRectangle
                width: 619
                height: 363
                visible: true
                opacity: 1
            }

            PropertyChanges {
                target: configButton
                visible: false
            }

            PropertyChanges {
                target: mealPlanTextArea
                x: 98
                y: 61
                width: 424
                height: 242
                readOnly: false
            }
        }
    ]
}
