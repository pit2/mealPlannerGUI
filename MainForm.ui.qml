import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.2

Item {
    id: page
    width: 640
    height: 480
    property alias lpPathInput: lpPathInput
    property alias clingoPathInput: clingoPathInput
    property alias saveButton: saveButton
    property alias configButton: configButton
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
        id: welcomeLabel
        x: 263
        width: 114
        height: 15
        color: "#600798"
        text: qsTr("Welcome to")
        anchors.horizontalCenterOffset: 51
        anchors.horizontalCenter: title.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 8
        textFormat: Text.RichText
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 12
    }

    Text {
        id: title
        x: 216
        width: 106
        height: 15
        color: "#0f6226"
        text: qsTr("FOOD PLANNER")
        anchors.horizontalCenterOffset: -59
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: welcomeLabel.bottom
        anchors.topMargin: 6
        font.capitalization: Font.AllUppercase
        font.bold: true
        font.pixelSize: 26
    }

    Button {
        id: startComputationButton
        x: 464
        y: 353
        text: qsTr("Show me food!")
        activeFocusOnPress: true
        isDefault: false
        tooltip: "Compute a meal plan using the current settings."
        checkable: false
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 101
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Rectangle {
        id: rect
        width: 600
        height: 250
        color: "#ffffff"
        anchors.left: parent.left
        anchors.leftMargin: 18
        anchors.top: parent.top
        anchors.topMargin: 60

        CheckBox {
            id: veganCheckbox
            x: 11
            y: 12
            text: qsTr("vegan")
            anchors.top: parent.top
            anchors.topMargin: 10
            anchors.left: parent.left
            anchors.leftMargin: 10
            activeFocusOnPress: false
            checked: true
        }

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
    }

    Button {
        id: configButton
        x: 570
        text: qsTr("(!)")
        anchors.right: parent.right
        anchors.rightMargin: 22
        anchors.top: parent.top
        anchors.topMargin: 18
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
                text: qsTr("Path/To/DirectoryWithLPFiles")
            }
        }
    ]
}
