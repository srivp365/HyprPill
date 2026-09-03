// components/PillBar.qml
import QtQuick

Rectangle {
    id: pillBackground

    HoverHandler {
        id: mouse
        acceptedDevices: PointerDevice.Mouse | PointerDevice.TouchPad
    }


    property bool isExpanded: mouse.hovered
    
    width: isExpanded ? 320 : 125
    height: isExpanded ? 240 : 40
    
    radius: isExpanded ? 25 : height / 2 
    color: "#000000" 
    
    // animation magic, where Behaviour intercepts changes in width height etc. and smooths it out (waowwww that's pretty nice)
    Behavior on width { NumberAnimation { duration: 300; easing.type: Easing.OutExpo } }
    Behavior on height { NumberAnimation { duration: 300; easing.type: Easing.OutExpo } }
    Behavior on radius { NumberAnimation { duration: 300; easing.type: Easing.OutExpo } }
    

    FontLoader {
        id: msPrint
        source: "../assets/fonts/MatrixSansPrint-Regular.otf"
    }

    

    // The content
    Row {
        anchors.centerIn: parent
        spacing: 20
        
        Text { 
            text: "1:00 PM"
            color: "#cdd6f4"
            font.pixelSize: 14
            font.family: msPrint.font.family
        }
    }
}