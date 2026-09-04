import QtQuick
import QtQuick.Layouts
import Quickshell.Io
import Quickshell.Services.UPower

Rectangle {
    id: statsCard
    width: parent.width
    height: 60  
    radius: 16
    color: "#000000" 
    border.color: "#1F1F1F"
    property string usedPercentage: "..."

    // calculate ram usage
    FileView {
        id: meminfoReader
        path: "/proc/meminfo"
        
        onLoaded: {
            const content = text(); 
            
            const totalMatch = content.match(/MemTotal:\s+(\d+)/);
            const availableMatch = content.match(/MemAvailable:\s+(\d+)/);

            if (totalMatch && availableMatch) {
                const total = parseInt(totalMatch[1], 10);
                const available = parseInt(availableMatch[1], 10);

                const used = total - available;
                
                if (total > 0) {
                    statsCard.usedPercentage = String(Math.round((used / 1024)));

                }
            }
        }
    }

    Timer {
        // change this for faster ram updates
        interval: 2000 
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: meminfoReader.reload()
    }

    RowLayout {
        anchors.fill: parent
        anchors.margins: 12
        spacing: 15

        ColumnLayout {
            Layout.fillWidth: true 
            spacing: 2

            

            Row {
                spacing: 6
                Text { 
                    text: ""
                    color: "#23d18b"
                    font.family: "Symbols Nerd Font"
                    font.pixelSize: 9 
                    anchors.verticalCenter: parent.verticalCenter
                }
                Text { 
                    text: "Ram"
                    color: "#8a8a90" 
                    font.family: martianMono.font.family
                    font.pixelSize: 10 
                    anchors.verticalCenter: parent.verticalCenter
                }
            }

           
            Row {
                spacing: 2
                Text { 
                    text: statsCard.usedPercentage
                    color: "#ffffff"
                    font.family: martianMono.font.family
                    font.pixelSize: 12 
                }
                Text { 
                    text: "MB"
                    color: "#8a8a90"
                    font.family: martianMono.font.family
                    font.pixelSize: 8 
                    anchors.baseline: parent.bottom 
                }
            }
        }

        Rectangle {
            Layout.preferredWidth: 1
            Layout.preferredHeight: 28
            color: "#1F1F1F" 
        }


        ColumnLayout {
            id: batteryInfo
            Layout.fillWidth: true
            spacing: 2 // Tighter spacing to match RAM column

            readonly property var battery: UPower.displayDevice
            

            function getCharging(state) {
                return state === 1 || state === 4;
            }

            // Top Row: Icon + Label
            Row {
                spacing: 6
                Text { 
                    text: (batteryInfo.battery && (batteryInfo.battery.state === 1 || batteryInfo.battery.state === 4)) ? "󱐋" : "󰁹"
                    color: (batteryInfo.battery && (batteryInfo.battery.state === 1 || batteryInfo.battery.state === 4)) ?"#FFFF00" : "#23d18b"
                    font.family: "Symbols Nerd Font"
                    font.pixelSize: 10
                    anchors.verticalCenter: parent.verticalCenter
                }
                Text { 
                    text: "Battery"
                    color: "#8a8a90"
                    font.family: martianMono.font.family
                    font.pixelSize: 10 
                    anchors.verticalCenter: parent.verticalCenter
                }
            }

            Row {
                Text { 
                    // Just the number!
                    text: batteryInfo.battery ? `${Math.round(batteryInfo.battery.percentage * 100)}%` : "--"
                    color: "#ffffff"
                    font.family: martianMono.font.family
                    font.pixelSize: 12
                }
            }
        }


        Rectangle {
            Layout.preferredWidth: 1
            Layout.preferredHeight: 28
            color: "#1F1F1F"
        }


        ColumnLayout {
            id: dndCol
            Layout.fillWidth: true
            spacing: 2

            property bool isDND: false

            Process {
                id: toggleDndProcess
                command: ["makoctl", "mode", "-t", "dnd"]
            }

            Process {
                id: startupDndCheck
                command: ["makoctl", "mode"]
                
                // When the command finishes running, check the output
                onRunningChanged: {
                    if (!running) {
                        // Quickshell stores stdout as an array, so we join it into a string
                        const output = stdout.join(" ");
                        dndCol.isDND = output.includes("dnd");
                    }
                }
            }

            Component.onCompleted: {
                startupDndCheck.running = true;
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    dndCol.isDND = !dndCol.isDND
                    toggleDndProcess.running = true

                }
                cursorShape: Qt.PointingHandCursor 
            }

            Row {
                spacing: 6
                Text { 
                    text: dndCol.isDND ? "󰍶" : "󰍡"
                    color: dndCol.isDND ? "#f14c4c" : "#8a8a90"
                    font.family: "Symbols Nerd Font"
                    font.pixelSize: 9
                    anchors.verticalCenter: parent.verticalCenter
                }
                Text { 
                    text: "DND"
                    color: "#8a8a90"
                    font.family: martianMono.font.family
                    font.pixelSize: 10 
                    anchors.verticalCenter: parent.verticalCenter
                }
            }

            Text { 
                text: dndCol.isDND ? "On" : "Off"
                color: dndCol.isDND ? "#f14c4c" : "#8a8a90"
                font.family: martianMono.font.family
                font.pixelSize: 12

                Behavior on color { ColorAnimation { duration: 150 } }
            }
        }
    }
}