import QtQuick
import QtQuick.Layouts
import Quickshell.Services.Mpris

Rectangle {
    id: musicCard
    width: parent.width
    height: 84
    radius: 16
    color: "#000000"
    border.color: "#1F1F1F"
    border.width: 1

    property var player: Mpris.players.values[0]
    

        RowLayout {
            anchors.leftMargin: 12
            anchors.rightMargin: 12
            anchors.fill: parent
            width: parent.width
            spacing: 10


            // Album Art
            Rectangle {
                width: 38
                height: 38
                // radius not applying, have to check
                radius: 10
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
                    font.pixelSize: 11
                    font.family: martianMono.font.family
                    elide: Text.ElideRight
                }
                Text {
                    width: parent.width
                    text: player ? player.trackArtist : "Open a media player"
                    color: "#8a8a90"
                    font.pixelSize: 9
                    font.family: martianMono.font.family
                    elide: Text.ElideRight
                }
            }

            Item { Layout.fillWidth: true }

            RowLayout {
                spacing: 10
                Layout.alignment: Qt.AlignVCenter

                Rectangle {
                    width: 22; height: 22; radius: 11; color: "transparent"
                    Text { anchors.centerIn: parent; text: "󰒮"; color: "#8a8a90"; font.pixelSize: 13 }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: if (player && player.canGoPrevious) player.previous()
                        cursorShape: Qt.PointingHandCursor 
                    }
                }

                Rectangle {
                    width: 26; height: 26; radius: 13; color: "#ffb454"
                    Text { 
                        anchors.centerIn: parent
                        text: (player && player.playbackState === MprisPlaybackState.Playing) ? "" : " "
                        color: "#241605"
                        font.pixelSize: 10 
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: if (player) player.togglePlaying()
                        cursorShape: Qt.PointingHandCursor
                    }
                }

                Rectangle {
                    width: 22; height: 22; radius: 11; color: "transparent"
                    Text { anchors.centerIn: parent; text: "󰒭"; color: "#8a8a90"; font.pixelSize: 13 }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: if (player && player.canGoNext) player.next()
                        cursorShape: Qt.PointingHandCursor
                    }
                }
            }
        }

        
        }
    


