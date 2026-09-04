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

    width: 500
    height: 680 
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