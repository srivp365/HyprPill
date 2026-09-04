import QtQuick
import Quickshell.Io
import Quickshell
import Quickshell.Services.Pipewire

import QtQuick.Layouts

Rectangle {
    id: pillBackground

    HoverHandler {
        id: mouse
        acceptedDevices: PointerDevice.Mouse | PointerDevice.TouchPad
    }

    property string time: "Loading..."
    property string date: "Loading..."
    property string username: Quickshell.env("USER") ?? "unknown"
    
    property var sink: Pipewire.defaultAudioSink
    PwObjectTracker { objects: [pillBackground.sink] }
    property int currentVolume: Math.round((sink?.audio?.volume ?? 0) * 100)
    property bool isMuted: sink?.audio?.muted ?? false

    onCurrentVolumeChanged: volumeTimer.restart()
    onIsMutedChanged: volumeTimer.restart()

    Timer {
        id: volumeTimer
        interval: 2000
    }

    property bool isVolumeActive: volumeTimer.running
    property bool isExpanded: mouse.hovered
    
    width: isExpanded ? 400 : (isVolumeActive ? 240 : 132)
    height: isExpanded ? 630 : 36
    
    radius: isExpanded ? 25 : height / 2 
    color: "#000000" 
    
    Behavior on width { NumberAnimation { duration: 300; easing.type: Easing.OutExpo } }
    Behavior on height { NumberAnimation { duration: 300; easing.type: Easing.OutExpo } }
    Behavior on radius { NumberAnimation { duration: 300; easing.type: Easing.OutExpo } }

    FontLoader {
        id: martianMono
        source: "../assets/fonts/MartianMono-VariableFont_wdth,wght.ttf"
    }

    Row {
        anchors.centerIn: parent
        spacing: 20
        
        opacity: (isExpanded || isVolumeActive) ? 0 : 1
        visible: opacity > 0
        Behavior on opacity { NumberAnimation { duration: 100 } }

        Text { 
            id: clockText
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
                }
            }
        } 
    }

    // 2. Volume OSD written by ai
    RowLayout {
        anchors.centerIn: parent
        spacing: 12
        width: parent.width - 30

        opacity: (!isExpanded && isVolumeActive) ? 1 : 0
        visible: opacity > 0
        Behavior on opacity { NumberAnimation { duration: 150 } }

        Text {
            text: pillBackground.isMuted ? "󰝟" : (pillBackground.currentVolume > 50 ? "󰕾" : "󰖀")
            color: pillBackground.isMuted ? "#f14c4c" : "#5b9dff" 
            font.family: "Symbols Nerd Font"
            font.pixelSize: 16
        }

        Rectangle {
            Layout.fillWidth: true
            height: 6
            radius: 3
            color: "#1F1F1F"
            implicitWidth: 120

            Rectangle {
                width: parent.width * (Math.min(pillBackground.currentVolume, 100) / 100)
                height: parent.height
                radius: 3
                color: pillBackground.isMuted ? "#404040" : "#5b9dff"

                Behavior on width { NumberAnimation { duration: 150; easing.type: Easing.OutQuad } }
            }
        }

        Text {
            text: `${pillBackground.currentVolume}%`
            color: "#ffffff"
            font.family: martianMono.font.family
            font.pixelSize: 11
        }
    }

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
            NotificationsCard {}
            PowerCard {}
        }
    }
}