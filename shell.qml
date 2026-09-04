import QtQuick
import "components" 
import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Wayland
import QtQuick.Layouts

ShellRoot {
    PanelWindow {
        id: barWindow    
        anchors {
            bottom: false
            top: true
            right: false
            left: false

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
}