import QtQuick
import Quickshell.Io

import qs.widgets

CBarItem {
    id: root
    required property QtObject barWindow

    text: "󰍜"
    onClicked: toggle_swaync.running = true
    // onClicked: () => root.controlPanelWindow.visible = !root.controlPanelWindow.visible

    IpcHandler {
        target: "control-center"
        function toggle(): void {
            toggle_swaync.running = true;
        }
    }

    Process {
        id: toggle_swaync
        command: ["swaync-client", "-t", "-sw"]
    }
}
