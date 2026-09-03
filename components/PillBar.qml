// components/PillBar.qml
import QtQuick

Rectangle {
    id: pillBackground
    
    // Default unexpanded state
    width: 200
    height: 40
    
    // Keep it perfectly rounded dynamically
    radius: height / 2 
    color: "#aa000000" 
    
    // The animation rules
    Behavior on width { NumberAnimation { duration: 300; easing.type: Easing.OutExpo } }
    Behavior on height { NumberAnimation { duration: 300; easing.type: Easing.OutExpo } }
    Behavior on radius { NumberAnimation { duration: 300; easing.type: Easing.OutExpo } }
    
    // 1. Load the Doto font (adjust the filename to match exactly what you downloaded!)
    FontLoader {
        id: dotoFont
        source: "../assets/fonts/Doto-VariableFont_ROND,wght.ttf"
    }

    FontLoader {
        id: msPrint
        source: "../assets/fonts/MatrixSansPrint-Regular.otf"
    }

    // The content
    Row {
        anchors.centerIn: parent
        spacing: 20
        
        Text { 
            text: "🔋 100%"
            color: "#cdd6f4"
            font.pixelSize: 14
            font.family: msPrint.font.family
        }
        Text { 
            text: "1:00 PM"
            color: "#cdd6f4"
            font.pixelSize: 14
            font.family: msPrint.font.family
        }
    }
}