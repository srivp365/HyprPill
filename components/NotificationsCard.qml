import QtQuick
import QtQuick.Layouts
import Quickshell.Io

Rectangle {
    id: notifsCard
    width: parent.width
    height: 225  
    radius: 16
    color: "#000000" 
    border.color: "#1F1F1F"

    Column {
        width: parent.width
        height: 100
        anchors.fill: parent
        anchors.margins: 12

        RowLayout {
            width: parent.width
            Text {
                text: "Notifications"
                color: "#8a8a90"
                font.family: martianMono.font.family
                font.pixelSize: 10
            }

            Text {
                text: "(3)"
                color: "#ffffff"
                font.family: martianMono.font.family
                font.pixelSize: 10
            }

            Item {
                Layout.fillWidth: true
            }


            Process {
              id: clearAllProcess
              command : ["makoctl", "dismiss -a"]  
            }

            Text {
                id: clearAllText
                text: "clear all"
                color: "#8a8a90"
                font.family: martianMono.font.family
                font.pixelSize: 9

                MouseArea {
                anchors.fill: parent
                onClicked: {

                }
                hoverEnabled:  true
                onEntered: {
                  clearAllText.color = "#ffffff"
                }
                onExited: {
                  clearAllText.color = "#8a8a90"
                }
                cursorShape: Qt.PointingHandCursor 
              }

            }
        
        }
    }
}
