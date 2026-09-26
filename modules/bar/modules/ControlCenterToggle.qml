import QtQuick
import Quickshell.Io

import qs.widgets
import qs.services

CBarItem {
    id: root
    required property QtObject barWindow

    text: "󰍜"
    onClicked: ShellService.controlCenterWindow.toggleOpen()

    IpcHandler {
        target: "control-center"
        function toggle(): void {
            ShellService.controlCenterWindow.toggleOpen();
        }
    }
}
