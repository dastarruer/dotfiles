import Quickshell
import QtQuick

Item {
    implicitWidth: clock.implicitWidth
    implicitHeight: clock.implicitHeight
    anchors.centerIn: parent

    SystemClock {
        id: timeSource
        precision: SystemClock.Minutes
    }

    Text {
        id: clock
        text: Qt.formatDateTime(timeSource.date, "hh:mm dddd, MMM dd").toLowerCase()
    }
}
