import QtQuick
import Quickshell.Io
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
    
    width: isExpanded ? 400 : 132
    height: isExpanded ? 630 : 36
    
    radius: isExpanded ? 25 : height / 2 
    color: "#000000" 
    
    // animation magic, where Behaviour intercepts changes in width height etc. and smooths it out (waowwww that's pretty nice)
    Behavior on width { NumberAnimation { duration: 300; easing.type: Easing.OutExpo } }
    Behavior on height { NumberAnimation { duration: 300; easing.type: Easing.OutExpo } }
    Behavior on radius { NumberAnimation { duration: 300; easing.type: Easing.OutExpo } }
    

    FontLoader {
        id: martianMono
        source: "../assets/fonts/MartianMono-VariableFont_wdth,wght.ttf"
    }

    

    // The pill view
    Row {
        anchors.centerIn: parent
        spacing: 20
        
        opacity: isExpanded ? 0 : 1
        visible: opacity > 0
        
        Behavior on opacity { NumberAnimation { duration: 100 } }

        
        Text { 
            id: clockText

            // fallback
            text: pillBackground.time 
            color: "#cdd6f4"
            font.pixelSize: 12
            font.family: martianMono.font.family
            font.weight: 500


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
        anchors.margins: 16

        opacity: isExpanded ? 1 : 0
        visible: opacity > 0
        Behavior on opacity { NumberAnimation { duration: isExpanded ? 50 : 200 } }

        Column {
            anchors.fill: parent
            spacing: 9

            HeaderCard {}
            MusicPlayer {}
            Row {
                width: parent.width - 15
                height: 86
                spacing: 12
                WifiCard {}
                BluetoothCard {}

            }
            InfoCard {}
            
        }


    }
 
}
