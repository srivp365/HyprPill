import QtQuick
import QtQuick.Layouts
import Quickshell.Io

RowLayout {
    width: parent.width
    height: 55
    spacing: 10

    // ==========================================
    // 1. LOCK BUTTON
    // ==========================================
    Rectangle {
        id: lockCard
        Layout.fillWidth: true 
        Layout.preferredHeight: 55 
        radius: 16
        
        property bool isArmed: false
        property color baseColor: "#8a8a90"
        property color armedColor: "#ffb454" 
        
        color: isArmed ? Qt.rgba(armedColor.r, armedColor.g, armedColor.b, 0.15) : "#000000"
        border.color: isArmed ? armedColor : "#1F1F1F"
        
        Behavior on color { ColorAnimation { duration: 250 } }
        Behavior on border.color { ColorAnimation { duration: 250 } }

        Process {
            id: lockProcess
            command: ["systemctl", "suspend"]
        }

        Timer {
            id: lockTimer
            interval: 2200
            onTriggered: lockCard.isArmed = false
        }

        Rectangle {
            id: lockPulse
            anchors.centerIn: parent
            width: parent.width; height: parent.height
            radius: 16; color: "transparent"
            border.color: lockCard.armedColor; border.width: 2
            visible: lockCard.isArmed; opacity: 0

            SequentialAnimation {
                running: lockCard.isArmed; loops: Animation.Infinite
                ParallelAnimation {
                    NumberAnimation { target: lockPulse; property: "width"; from: lockCard.width; to: lockCard.width + 12; duration: 1100; easing.type: Easing.OutQuad }
                    NumberAnimation { target: lockPulse; property: "height"; from: lockCard.height; to: lockCard.height + 12; duration: 1100; easing.type: Easing.OutQuad }
                    NumberAnimation { target: lockPulse; property: "opacity"; from: 0.6; to: 0; duration: 1100; easing.type: Easing.OutQuad }
                }
            }
        }

        MouseArea {
            anchors.fill: parent; cursorShape: Qt.PointingHandCursor
            onClicked: {
                if (lockCard.isArmed) {
                    lockProcess.running = true; lockCard.isArmed = false; lockTimer.stop()
                } else {
                    lockCard.isArmed = true; lockTimer.restart()
                }
            }
        }

        Column {
            anchors.centerIn: parent; spacing: 4 
            Text {
                text: ""; color: lockCard.isArmed ? lockCard.armedColor : lockCard.baseColor
                font.family: "Symbols Nerd Font"; font.pixelSize: 14; anchors.horizontalCenter: parent.horizontalCenter 
                Behavior on color { ColorAnimation { duration: 250 } }
            }
            Text {
                text: lockCard.isArmed ? "Confirm?" : "Sleep"
                color: lockCard.isArmed ? lockCard.armedColor : lockCard.baseColor
                font.family: martianMono.font.family; font.pixelSize: 10; anchors.horizontalCenter: parent.horizontalCenter 
                Behavior on color { ColorAnimation { duration: 250 } }
            }
        }
    }

    // ==========================================
    // 2. LOGOUT BUTTON
    // ==========================================
    Rectangle {
        id: logoutCard
        Layout.fillWidth: true 
        Layout.preferredHeight: 55 
        radius: 16
        
        property bool isArmed: false
        property color baseColor: "#8a8a90"
        property color armedColor: "#5b9dff" 
        
        color: isArmed ? Qt.rgba(armedColor.r, armedColor.g, armedColor.b, 0.15) : "#000000"
        border.color: isArmed ? armedColor : "#1F1F1F"
        
        Behavior on color { ColorAnimation { duration: 250 } }
        Behavior on border.color { ColorAnimation { duration: 250 } }

        Process {
            id: logoutProcess
            // Exits Hyprland directly
            command: ["hyprctl", "dispatch", "exit"] 
        }

        Timer {
            id: logoutTimer
            interval: 2200
            onTriggered: logoutCard.isArmed = false
        }

        Rectangle {
            id: logoutPulse
            anchors.centerIn: parent
            width: parent.width; height: parent.height
            radius: 16; color: "transparent"
            border.color: logoutCard.armedColor; border.width: 2
            visible: logoutCard.isArmed; opacity: 0

            SequentialAnimation {
                running: logoutCard.isArmed; loops: Animation.Infinite
                ParallelAnimation {
                    NumberAnimation { target: logoutPulse; property: "width"; from: logoutCard.width; to: logoutCard.width + 12; duration: 1100; easing.type: Easing.OutQuad }
                    NumberAnimation { target: logoutPulse; property: "height"; from: logoutCard.height; to: logoutCard.height + 12; duration: 1100; easing.type: Easing.OutQuad }
                    NumberAnimation { target: logoutPulse; property: "opacity"; from: 0.6; to: 0; duration: 1100; easing.type: Easing.OutQuad }
                }
            }
        }

        MouseArea {
            anchors.fill: parent; cursorShape: Qt.PointingHandCursor
            onClicked: {
                if (logoutCard.isArmed) {
                    logoutProcess.running = true; logoutCard.isArmed = false; logoutTimer.stop()
                } else {
                    logoutCard.isArmed = true; logoutTimer.restart()
                }
            }
        }

        Column {
            anchors.centerIn: parent; spacing: 4 
            Text {
                text: "󰍃"; color: logoutCard.isArmed ? logoutCard.armedColor : logoutCard.baseColor
                font.family: "Symbols Nerd Font"; font.pixelSize: 14; anchors.horizontalCenter: parent.horizontalCenter 
                Behavior on color { ColorAnimation { duration: 250 } }
            }
            Text {
                text: logoutCard.isArmed ? "Confirm?" : "Logout"
                color: logoutCard.isArmed ? logoutCard.armedColor : logoutCard.baseColor
                font.family: martianMono.font.family; font.pixelSize: 10; anchors.horizontalCenter: parent.horizontalCenter 
                Behavior on color { ColorAnimation { duration: 250 } }
            }
        }
    }

    // ==========================================
    // 3. RESTART BUTTON
    // ==========================================
    Rectangle {
        id: restartCard
        Layout.fillWidth: true 
        Layout.preferredHeight: 55 
        radius: 16
        
        property bool isArmed: false
        property color baseColor: "#8a8a90"
        property color armedColor: "#4ade80" 
        
        color: isArmed ? Qt.rgba(armedColor.r, armedColor.g, armedColor.b, 0.15) : "#000000"
        border.color: isArmed ? armedColor : "#1F1F1F"
        
        Behavior on color { ColorAnimation { duration: 250 } }
        Behavior on border.color { ColorAnimation { duration: 250 } }

        Process {
            id: restartProcess
            command: ["systemctl", "reboot"] 
        }

        Timer {
            id: restartTimer
            interval: 2200
            onTriggered: restartCard.isArmed = false
        }

        Rectangle {
            id: restartPulse
            anchors.centerIn: parent
            width: parent.width; height: parent.height
            radius: 16; color: "transparent"
            border.color: restartCard.armedColor; border.width: 2
            visible: restartCard.isArmed; opacity: 0

            SequentialAnimation {
                running: restartCard.isArmed; loops: Animation.Infinite
                ParallelAnimation {
                    NumberAnimation { target: restartPulse; property: "width"; from: restartCard.width; to: restartCard.width + 12; duration: 1100; easing.type: Easing.OutQuad }
                    NumberAnimation { target: restartPulse; property: "height"; from: restartCard.height; to: restartCard.height + 12; duration: 1100; easing.type: Easing.OutQuad }
                    NumberAnimation { target: restartPulse; property: "opacity"; from: 0.6; to: 0; duration: 1100; easing.type: Easing.OutQuad }
                }
            }
        }

        MouseArea {
            anchors.fill: parent; cursorShape: Qt.PointingHandCursor
            onClicked: {
                if (restartCard.isArmed) {
                    restartProcess.running = true; restartCard.isArmed = false; restartTimer.stop()
                } else {
                    restartCard.isArmed = true; restartTimer.restart()
                }
            }
        }

        Column {
            anchors.centerIn: parent; spacing: 4 
            Text {
                text: ""; color: restartCard.isArmed ? restartCard.armedColor : restartCard.baseColor
                font.family: "Symbols Nerd Font"; font.pixelSize: 14; anchors.horizontalCenter: parent.horizontalCenter 
                Behavior on color { ColorAnimation { duration: 250 } }
            }
            Text {
                text: restartCard.isArmed ? "Confirm?" : "Restart"
                color: restartCard.isArmed ? restartCard.armedColor : restartCard.baseColor
                font.family: martianMono.font.family; font.pixelSize: 10; anchors.horizontalCenter: parent.horizontalCenter 
                Behavior on color { ColorAnimation { duration: 250 } }
            }
        }
    }

    // ==========================================
    // 4. SHUTDOWN BUTTON
    // ==========================================
    Rectangle {
        id: shutdownCard
        Layout.fillWidth: true 
        Layout.preferredHeight: 55 
        radius: 16
        
        property bool isArmed: false
        property color baseColor: "#8a8a90"
        property color armedColor: "#f75f5f" 
        
        color: isArmed ? Qt.rgba(armedColor.r, armedColor.g, armedColor.b, 0.15) : "#000000"
        border.color: isArmed ? armedColor : "#1F1F1F"
        
        Behavior on color { ColorAnimation { duration: 250 } }
        Behavior on border.color { ColorAnimation { duration: 250 } }

        Process {
            id: shutdownProcess
            command: ["systemctl", "poweroff"] 
        }

        Timer {
            id: shutdownTimer
            interval: 2200
            onTriggered: shutdownCard.isArmed = false
        }

        Rectangle {
            id: shutdownPulse
            anchors.centerIn: parent
            width: parent.width; height: parent.height
            radius: 16; color: "transparent"
            border.color: shutdownCard.armedColor; border.width: 2
            visible: shutdownCard.isArmed; opacity: 0

            SequentialAnimation {
                running: shutdownCard.isArmed; loops: Animation.Infinite
                ParallelAnimation {
                    NumberAnimation { target: shutdownPulse; property: "width"; from: shutdownCard.width; to: shutdownCard.width + 12; duration: 1100; easing.type: Easing.OutQuad }
                    NumberAnimation { target: shutdownPulse; property: "height"; from: shutdownCard.height; to: shutdownCard.height + 12; duration: 1100; easing.type: Easing.OutQuad }
                    NumberAnimation { target: shutdownPulse; property: "opacity"; from: 0.6; to: 0; duration: 1100; easing.type: Easing.OutQuad }
                }
            }
        }

        MouseArea {
            anchors.fill: parent; cursorShape: Qt.PointingHandCursor
            onClicked: {
                if (shutdownCard.isArmed) {
                    shutdownProcess.running = true; shutdownCard.isArmed = false; shutdownTimer.stop()
                } else {
                    shutdownCard.isArmed = true; shutdownTimer.restart()
                }
            }
        }

        Column {
            anchors.centerIn: parent; spacing: 4 
            Text {
                text: "⏻"; color: shutdownCard.isArmed ? shutdownCard.armedColor : shutdownCard.baseColor
                font.family: "Symbols Nerd Font"; font.pixelSize: 14; anchors.horizontalCenter: parent.horizontalCenter 
                Behavior on color { ColorAnimation { duration: 250 } }
            }
            Text {
                text: shutdownCard.isArmed ? "Confirm?" : "Shut Down"
                color: shutdownCard.isArmed ? shutdownCard.armedColor : shutdownCard.baseColor
                font.family: martianMono.font.family; font.pixelSize: 10; anchors.horizontalCenter: parent.horizontalCenter 
                Behavior on color { ColorAnimation { duration: 250 } }
            }
        }
    }
}