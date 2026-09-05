import QtQuick
import QtQuick.Layouts
import Quickshell.Io
import Quickshell
import Quickshell.Services.Pipewire

Rectangle {
    id: pillBackground

    HoverHandler {
        id: mouse
        acceptedDevices: PointerDevice.Mouse | PointerDevice.TouchPad
    }

    property string time: "Loading..."
    property string date: "Loading..."
    property string username: Quickshell.env("USER") ?? "unknown"

    // 1. Pipewire integration for volume
    property var sink: Pipewire.defaultAudioSink
    PwObjectTracker { objects: [pillBackground.sink] }
    property int currentVolume: Math.round((sink?.audio?.volume ?? 0) * 100)
    property bool isMuted: sink?.audio?.muted ?? false

    onCurrentVolumeChanged: volumeTimer.restart()
    onIsMutedChanged: volumeTimer.restart()

    Timer {
        id: volumeTimer
        interval: 1000
    }

    // 2. Brightness integration via sysfs (instant, event-driven — no polling)
    property string backlightDevice: ""
    property int maxBrightness: 1
    property int rawBrightness: 0
    property int currentBrightness: maxBrightness > 0
        ? Math.round(rawBrightness * 100 / maxBrightness)
        : 0
    property bool brightnessInitialized: false

    // Find the backlight device name once at startup
    Process {
        id: detectBacklight
        command: ["sh", "-c", "ls /sys/class/backlight | head -n1"]
        running: true
        stdout: SplitParser {
            onRead: data => {
                pillBackground.backlightDevice = data.trim()
            }
        }
    }

    FileView {
        id: maxBrightnessFile
        path: pillBackground.backlightDevice
            ? `/sys/class/backlight/${pillBackground.backlightDevice}/max_brightness`
            : ""
        onLoaded: pillBackground.maxBrightness = parseInt(text())
    }

    FileView {
        id: brightnessFile
        path: pillBackground.backlightDevice
            ? `/sys/class/backlight/${pillBackground.backlightDevice}/brightness`
            : ""
        watchChanges: true
        onFileChanged: reload()
        onLoaded: {
            pillBackground.rawBrightness = parseInt(text())
            pillBackground.brightnessInitialized = true
        }
    }

    onCurrentBrightnessChanged: {
        if (brightnessInitialized) brightnessTimer.restart()
    }

    Timer {
        id: brightnessTimer
        interval: 1000
    }

    property bool isVolumeActive: volumeTimer.running
    property bool isBrightnessActive: brightnessTimer.running
    property bool isExpanded: mouse.hovered

    // Dynamic sizing: Normal (132), Sliders (240), Control Center (400)
    width: isExpanded ? 400 : ((isVolumeActive || isBrightnessActive) ? 240 : 132)
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

    // 1. Normal State (Clock)
    Row {
        anchors.centerIn: parent
        spacing: 20

        opacity: (isExpanded || isVolumeActive || isBrightnessActive) ? 0 : 1
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

    // 2. Volume OSD State
    RowLayout {
        anchors.centerIn: parent
        spacing: 12
        width: parent.width - 30

        opacity: (!isExpanded && isVolumeActive) ? 1 : 0
        visible: opacity > 0
        Behavior on opacity { NumberAnimation { duration: 150 } }

        Text {
            id: volumeIcon
            text: pillBackground.isMuted ? "󰝟" : (pillBackground.currentVolume > 50 ? "󰕾" : "󰖀")
            color: pillBackground.isMuted ? "#f14c4c" : "#5b9dff"
            font.family: "Symbols Nerd Font"
            font.pixelSize: 16
            onTextChanged: volIconAnim.restart()

            SequentialAnimation {
                id: volIconAnim
                NumberAnimation { target: volumeIcon; property: "scale"; to: 0.5; duration: 75; easing.type: Easing.InQuad }
                NumberAnimation { target: volumeIcon; property: "scale"; to: 1.0; duration: 75; easing.type: Easing.OutBack }
            }
        }

        Rectangle {
            id: volumeSliderTrack
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

            MouseArea {
                anchors.fill: parent
                anchors.margins: -10
                function updateVolume(mouseX) {
                    if (!pillBackground.sink?.audio) return;
                    let percentage = Math.max(0, Math.min(mouseX / volumeSliderTrack.width, 1.0));
                    pillBackground.sink.audio.volume = percentage;
                    if (pillBackground.sink.audio.muted && percentage > 0) {
                        pillBackground.sink.audio.muted = false;
                    }
                    volumeTimer.restart();
                }
                onPressed: (mouse) => updateVolume(mouse.x)
                onPositionChanged: (mouse) => { if (pressed) updateVolume(mouse.x) }
            }
        }

        Text {
            text: `${pillBackground.currentVolume}%`
            color: "#ffffff"
            font.family: martianMono.font.family
            font.pixelSize: 11
        }
    }

    // 3. Brightness OSD State
    RowLayout {
        anchors.centerIn: parent
        spacing: 12
        width: parent.width - 30

        opacity: (!isExpanded && isBrightnessActive && !isVolumeActive) ? 1 : 0
        visible: opacity > 0
        Behavior on opacity { NumberAnimation { duration: 150 } }

        Text {
            id: brightnessIcon
            text: "󰃠"
            color: "#f9e2af"
            font.family: "Symbols Nerd Font"
            font.pixelSize: 16
        }

        Rectangle {
            id: brightnessSliderTrack
            Layout.fillWidth: true
            height: 6
            radius: 3
            color: "#1F1F1F"
            implicitWidth: 120

            Rectangle {
                width: parent.width * (Math.min(pillBackground.currentBrightness, 100) / 100)
                height: parent.height
                radius: 3
                color: "#f9e2af"
                Behavior on width { NumberAnimation { duration: 150; easing.type: Easing.OutQuad } }
            }

            MouseArea {
                anchors.fill: parent
                anchors.margins: -10

                Process { id: setBrightnessProc }

                function updateBrightness(mouseX) {
                    let percentage = Math.round(Math.max(0, Math.min(mouseX / brightnessSliderTrack.width, 1.0)) * 100);
                    setBrightnessProc.command = ["brightnessctl", "set", `${percentage}%`];
                    setBrightnessProc.running = true;
                    // Don't set currentBrightness manually here — the FileView
                    // watcher will pick up the real value once the kernel applies it.
                    brightnessTimer.restart();
                }

                onPressed: (mouse) => updateBrightness(mouse.x)
                onPositionChanged: (mouse) => { if (pressed) updateBrightness(mouse.x) }
            }
        }

        Text {
            text: `${pillBackground.currentBrightness}%`
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