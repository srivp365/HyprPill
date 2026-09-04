import QtQuick
import QtQuick.Layouts

RowLayout {
width: parent.width
height: 60

Column {
    Layout.alignment: Qt.AlignVCenter
    spacing: 2

    Text { 
        id: clockTextCC

        // fallback
        text: pillBackground.time 
        color: "#cdd6f4"
        font.pixelSize: 24
        font.family: msPrint.font.family
    
    }
    Text { 
        id: dateTextCC

        // fallback
        text: pillBackground.date 
        color: '#a9cdd6f4'
        font.pixelSize: 14
        font.family: msPrint.font.family
    
    }
}

    Item { Layout.fillWidth: true }

RowLayout {
    Layout.alignment: Qt.AlignVCenter
    spacing: 9

    Column {
        Layout.alignment: Qt.AlignVCenter
        Layout.preferredWidth: 80 

        Text {
            text: pillBackground.username
            color: "#e9e9ec"
            font.pixelSize: 11
            font.family: msPrint.font.family
            horizontalAlignment: Text.AlignRight
            anchors.right: parent.right
        }
        Text {
            id: uptimeText
            text: "up 4h 12m" 
            color: "#4ade80"
            font.pixelSize: 9
            font.family: msPrint.font.family
            horizontalAlignment: Text.AlignRight
            anchors.right: parent.right
        }
    }

        
    Rectangle {
        width: 36
        height: 36
        radius: 9
        color: "#5b9dff" 
        border.color: "#000000"

        Text {
            anchors.centerIn: parent
            text: pillBackground.username.substring(0, 2).toUpperCase()
            color: "#ffffff"
            font.pixelSize: 12
            font.family: msPrint.font.family
            font.bold: true
        }
    }

}
}