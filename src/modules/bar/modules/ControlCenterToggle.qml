import QtQuick
import Quickshell.Io

import qs.widgets

CText {
    id: root
    required property QtObject barWindow

    text: "󰍜"
    // onClicked: () => root.controlPanelWindow.visible = !root.controlPanelWindow.visible
    MouseArea {
      anchors.fill: parent

      cursorShape: Qt.PointingHandCursor
      onClicked: () => toggle_swaync.running = true
    }

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
