// shell.qml
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
    height: 500 
    color: "transparent"

    mask: Region {
        item: myPill
    }

    // Call our component!
    PillBar {
        id: myPill 
        
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
    }
}