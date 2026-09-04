import QtQuick
import QtQuick.Layouts

Rectangle {
    id: statsCard
    width: parent.width
    height: 60  
    radius: 16
    color: "#000000" 
    border.color: "#1F1F1F"

    RowLayout {
        anchors.fill: parent
        anchors.margins: 12
        spacing: 15

        ColumnLayout {
            Layout.fillWidth: true 
            spacing: 2

            Row {
                spacing: 6
                Text { 
                    text: ""
                    color: "#23d18b"
                    font.family: "Symbols Nerd Font"
                    font.pixelSize: 9 
                    anchors.verticalCenter: parent.verticalCenter
                }
                Text { 
                    text: "Ram"
                    color: "#8a8a90" 
                    font.family: martianMono.font.family
                    font.pixelSize: 10 
                    anchors.verticalCenter: parent.verticalCenter
                }
            }

           
            Row {
                spacing: 2
                Text { 
                    text: "407"
                    color: "#ffffff"
                    font.family: martianMono.font.family
                    font.pixelSize: 12 
                }
                Text { 
                    text: "MB"
                    color: "#8a8a90"
                    font.family: martianMono.font.family
                    font.pixelSize: 8 
                    anchors.baseline: parent.bottom 
                }
            }
        }

        Rectangle {
            Layout.preferredWidth: 1
            Layout.preferredHeight: 28
            color: "#1F1F1F" 
        }


        ColumnLayout {
            Layout.fillWidth: true
            spacing: 5

            Row {
                spacing: 6
                Text { 
                    text: "󰁹"
                    color: "#23d18b"
                    font.family: "Symbols Nerd Font"
                    font.pixelSize: 9
                    anchors.verticalCenter: parent.verticalCenter
                }
                Text { 
                    text: "Battery"
                    color: "#8a8a90"
                    font.family: martianMono.font.family
                    font.pixelSize: 10 
                    anchors.verticalCenter: parent.verticalCenter
                }
            }

            Text { 
                text: "86%"
                color: "#ffffff"
                font.family: martianMono.font.family
                font.pixelSize: 12
            }
        }


        Rectangle {
            Layout.preferredWidth: 1
            Layout.preferredHeight: 28
            color: "#1F1F1F"
        }


        ColumnLayout {
            Layout.fillWidth: true
            spacing: 2

            MouseArea {
                anchors.fill: parent
                onClicked: if (player && player.canGoPrevious) player.previous()
                cursorShape: Qt.PointingHandCursor 
            }

            Row {
                spacing: 6
                Text { 
                    text: "󰍶"
                    color: "#f14c4c"
                    font.family: "Symbols Nerd Font"
                    font.pixelSize: 9
                    anchors.verticalCenter: parent.verticalCenter
                }
                Text { 
                    text: "DND"
                    color: "#8a8a90"
                    font.family: martianMono.font.family
                    font.pixelSize: 10 
                    anchors.verticalCenter: parent.verticalCenter
                }
            }

            Text { 
                text: "On"
                color: "#f14c4c"
                font.family: martianMono.font.family
                font.pixelSize: 12
            }
        }
    }
}