import QtQuick
import Quickshell
import "components" 

PanelWindow {
    id: barWindow

    anchors {
        top: true
        bottom: false
        left: false
        right: false
    }

    margins { top: 10 }
    exclusiveZone: 30 

    width: 600
    height: 700 
    color: "transparent"

    mask: Region {
        item: myPill
    }

    PillBar {
        id: myPill 
        
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
    }
}