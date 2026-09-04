import QtQuick
import QtQuick.Layouts
import Quickshell.Services.Mpris

Rectangle {
    id: musicCard
    width: parent.width
    height: 70
    radius: 16
    color: "#000000"
    border.color: "#1F1F1F"

    Column {
        height: parent.height
        width: parent.width

        Row {
            padding: 20
            width: parent.width
            height: 50
            spacing: 10
            Text {
                text: "" 
                font.family: "Symbols Nerd Font"
                font.pixelSize: 12
                color: "#5b9dff" 
            }

            Text { 
                id: ramIC
                // fallback
                text: "Ram"
                color: "#cdd6f4"
                font.pixelSize: 12
                font.family: martianMono.font.family

            }
        }
    }



}