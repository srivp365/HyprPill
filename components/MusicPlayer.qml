import QtQuick
import QtQuick.Layouts
import Quickshell.Services.Mpris

Rectangle {
    id: musicCard
    width: parent.width
    height: 70
    radius: 16
    color: "#141519"
    border.color: "#1F1F1F"

    property var player: Mpris.players.values[0]

    Column {
        anchors.fill: parent
        anchors.margins: 12
        spacing: 11

        RowLayout {
            width: parent.width
            spacing: 10

            // Album Art
            Rectangle {
                width: 46
                height: 46
                radius: 11
                color: "#ffb454"
                clip: true

                Image {
                    anchors.fill: parent
                    source: player ? player.trackArtUrl : ""
                    fillMode: Image.PreserveAspectCrop
                }
            }

            Column {
                Layout.preferredWidth: 160
                Layout.fillWidth: true
                spacing: 4

                Text {
                    width: parent.width
                    text: player ? player.trackTitle : "No music playing"
                    color: "#e9e9ec"
                    font.pixelSize: 12
                    font.family: msPrint.font.family
                    elide: Text.ElideRight
                }
                Text {
                    width: parent.width
                    text: player ? player.trackArtist : "Open a media player"
                    color: "#8a8a90"
                    font.pixelSize: 9
                    font.family: msPrint.font.family
                    elide: Text.ElideRight
                }
            }

            Item { Layout.fillWidth: true }

            RowLayout {
                spacing: 10
                Layout.alignment: Qt.AlignVCenter

                Rectangle {
                    width: 26; height: 26; radius: 13; color: "transparent"
                    Text { anchors.centerIn: parent; text: "⏮"; color: "#8a8a90"; font.pixelSize: 10 }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: if (player && player.canGoPrevious) player.previous()
                    }
                }

                Rectangle {
                    width: 30; height: 30; radius: 15; color: "#ffb454"
                    Text { 
                        anchors.centerIn: parent
                        text: (player && player.playbackState === MprisPlaybackState.Playing) ? "⏸" : "▶"
                        color: "#241605"
                        font.pixelSize: 10 
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: if (player) player.togglePlaying()
                    }
                }

                Rectangle {
                    width: 26; height: 26; radius: 13; color: "transparent"
                    Text { anchors.centerIn: parent; text: "⏭"; color: "#8a8a90"; font.pixelSize: 10 }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: if (player && player.canGoNext) player.next()
                    }
                }
            }
        }

        
        }
    }


