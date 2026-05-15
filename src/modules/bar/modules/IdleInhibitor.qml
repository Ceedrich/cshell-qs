import Quickshell.Wayland as WL
import QtQuick

import qs.config
import qs.widgets

CText {
    id: root
    required property QtObject barWindow

    property bool inhibiting: false

    text: inhibiting ? "󰈈" : "󰈉"

    defaultColor: Colors.blue

    color: inhibiting ? defaultColor : Colors.overlay1

    WL.IdleInhibitor {
        enabled: root.inhibiting
        window: root.barWindow
    }

    MouseArea {
        anchors.fill: parent

        cursorShape: Qt.PointingHandCursor
        onClicked: () => root.inhibiting = !root.inhibiting
    }
}
