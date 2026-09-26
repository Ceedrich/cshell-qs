pragma Singleton

import Quickshell

import qs.modules.controlcenter

Singleton {
    id: root

    property ControlCenterWindow controlCenterWindow

    function sendNotification(summary: string, body: string) {
        Quickshell.execDetached(["notify-send", "-a", "cshell", summary, body]);
    }
}
