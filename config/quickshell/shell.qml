import Quickshell
import Quickshell.Io
import QtQuick

Variants {
    model: Quickshell.screens;

    delegate: Component {
        PanelWindow {
            required property var modelData
            screen: modelData

            anchors {
                top: true
                left: true
                right: true
            }
        
            implicitHeight: 30
        
            ClockWidget {}
        }
    }
}
