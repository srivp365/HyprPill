import QtQuick
import QtQuick.Layouts



Rectangle {
    id: wifiCard
    width: parent.width / 2
    height: parent.height
    radius: 16
    color: "#000000"
    border.color: "#1F1F1F"


    Column {
        width: parent.width
        height: parent.height
        anchors.fill: parent
        anchors.margins: 10
        spacing: 5

        RowLayout {
            width: parent.width
            height: 30

            Rectangle {
                Layout.preferredWidth: 18
                Layout.preferredHeight: 18
                Layout.alignment: Qt.AlignVCenter
                radius: 5
                color: Qt.rgba(167/255, 139/255, 250/255, 0.18)

                Text {
                    anchors.centerIn: parent
                    text: "󰂯"
                    color: "#a78bfa"
                    font.pixelSize: 9
                }
            }

            Text {
                text: "Bluetooth"
                color: "#8a8a90"
                font.pixelSize: 10
                Layout.alignment: Qt.AlignVCenter
                font.family: martianMono.font.family
            }

            Item {
                Layout.fillWidth: true
            }

            // Toggle made using AI
            Rectangle {
                id: toggleTrack
                
                property bool isOn: true 
                
                Layout.preferredWidth: 26
                Layout.preferredHeight: 16
                Layout.alignment: Qt.AlignVCenter
                radius: height / 2 // Perfect pill shape
                
                // The track color changes based on the state
                color: isOn ? "#a78bfa" : "#333333" 
                Behavior on color { ColorAnimation { duration: 200 } }

                // The invisible hit-box that listens for clicks
                MouseArea {
                    anchors.fill: parent
                    onClicked: toggleTrack.isOn = !toggleTrack.isOn
                    cursorShape: Qt.PointingHandCursor

                }

                // The inner knob
                Rectangle {
                    id: toggleKnob
                    width: 12
                    height: 12
                    radius: width / 2
                    
                    // The knob color
                    color: toggleTrack.isOn ? "#000000" : "#ffffff"
                    Behavior on color { ColorAnimation { duration: 200 } }
                    
                    // Vertically center the knob inside the track
                    y: (parent.height - height) / 2
                    
                    // THE ANIMATION MAGIC: Move left or right based on state
                    // 3px margin from the left if off, 3px from the right if on
                    x: toggleTrack.isOn ? (parent.width - width - 3) : 3 
                    
                    // Smoothly slide between the X coordinates
                    Behavior on x { NumberAnimation { duration: 200; easing.type: Easing.OutExpo } }
                }
            }
        }

        Text {
            text: "Buds"
            font.family: martianMono.font.family
            color: "#ffffff"
            font.pixelSize: 10

        }

        Text {
            text: "Tap to manage"
            font.family: martianMono.font.family
            color: "#8a8a90"
            font.pixelSize: 8

        }
    }
}