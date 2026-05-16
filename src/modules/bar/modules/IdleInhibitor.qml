import Quickshell.Wayland as WL
import QtQuick

import qs.config
import qs.widgets

CBarItem {
    id: root
    required property QtObject barWindow

    property bool inhibiting: false

    text: inhibiting ? "󰈈" : "󰈉"

    textColor: inhibiting ? Colors.blue : Colors.overlay1

    WL.IdleInhibitor {
        enabled: root.inhibiting
        window: root.barWindow
    }

    onClicked: root.inhibiting = !root.inhibiting
}
