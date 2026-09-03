// components/PillBar.qml
import QtQuick
import Quickshell.Io
import QtQuick.Layouts
import Quickshell

Rectangle {
    id: pillBackground

    HoverHandler {
        id: mouse
        acceptedDevices: PointerDevice.Mouse | PointerDevice.TouchPad
    }

    
    property string time: "Loading..."
    property string date: "Loading..."
    property string username: Quickshell.env("USER") ?? "unknown"
    property bool isExpanded: mouse.hovered
    
    width: isExpanded ? 500 : 120
    height: isExpanded ? 500 : 40
    
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

    

    // The pill view
    Row {
        anchors.centerIn: parent
        spacing: 20
        
        opacity: isExpanded ? 0 : 1
        visible: opacity > 0
        
        Behavior on opacity { NumberAnimation { duration: 50 } }

        
        Text { 
            id: clockText

            // fallback
            text: pillBackground.time 
            color: "#cdd6f4"
            font.pixelSize: 14
            font.family: msPrint.font.family


            Timer {
                interval: 1000
                running: true
                repeat: true
                triggeredOnStart: true

                onTriggered: {
                    let now = new Date()
                    pillBackground.time = Qt.formatTime(now, "hh:mm A")
                    let date = now.toDateString()
                    pillBackground.date = Qt.formatDate(now, "MMM d, yyyy")
                }
            }
        } 
    }

    // the control center
    Item {
        id: controlCenterPanel
        anchors.fill: parent
        anchors.margins: 25

        opacity: isExpanded ? 1 : 0
        visible: opacity > 0
        Behavior on opacity { NumberAnimation { duration: isExpanded ? 50 : 200 } }

        Column {
            anchors.fill: parent
            spacing: 15

            HeaderCard {}
            
        }


    }
 
}
