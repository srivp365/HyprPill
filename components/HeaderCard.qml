import QtQuick
import QtQuick.Layouts

RowLayout {
width: parent.width
height: 44

Column {
    Layout.alignment: Qt.AlignVCenter
    spacing: 2

    Text { 
        id: clockTextCC

        text: pillBackground.time 
        color: "#cdd6f4"
        font.pixelSize: 21
        font.family: martianMono.font.family
        font.weight: 500
    
    }
    Text { 
        id: dateTextCC
        
        text: pillBackground.date 
        color: '#a9cdd6f4'
        font.pixelSize: 9
        font.family: martianMono.font.family
    
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
            font.pixelSize: 10
            font.family: martianMono.font.family
            horizontalAlignment: Text.AlignRight
            anchors.right: parent.right
        }
        Text {
            id: uptimeText
            text: "up 4h 12m" 
            color: "#4ade80"
            font.pixelSize: 8
            font.family: martianMono.font.family
            horizontalAlignment: Text.AlignRight
            anchors.right: parent.right
        }
    }

        
    Rectangle {
        width: 31
        height: 31
        radius: 9
        color: "#5b9dff" 
        border.color: "#000000"

        Text {
            anchors.centerIn: parent
            text: pillBackground.username.substring(0, 2).toUpperCase()
            color: "#ffffff"
            font.pixelSize: 12
            font.family: martianMono.font.family
            font.bold: true
        }
    }

}
}