import QtQuick
import Quickshell.Io

import qs.widgets

CText {
    id: root
    required property QtObject barWindow

    text: "󰍜"
    // onClicked: () => root.controlPanelWindow.visible = !root.controlPanelWindow.visible
    onClicked: () => toggle_swaync.running = true

    Process {
        id: toggle_swaync
        command: ["swaync-client", "-t", "-sw"]
    }
}
