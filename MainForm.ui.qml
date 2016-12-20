import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.2

Item {
    id: page
    width: 640
    height: 480
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
            tickmarksEnabled: true
            stepSize: 1
            updateValueWhileDragging: false
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
            minimumValue: 30
            updateValueWhileDragging: false
            tickmarksEnabled: false
        }
    }
}
