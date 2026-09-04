import QtQuick
import QtQuick.Layouts

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

            Text {
                text: "clear all"
                color: "#8a8a90"
                font.family: martianMono.font.family
                font.pixelSize: 9
            }
        
        }
    }
}