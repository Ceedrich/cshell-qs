pragma Singleton

import Quickshell
import QtQuick

import qs.modules.controlcenter
import qs.Components

Singleton {
    id: root

    property ControlCenterWindow controlCenterWindow
    property Container mainBarContainer

    function showItem(item: Item, duration_secs = 5) {
        if (item) {
            mainBarContainer.overrideItem = item;
            mainBarContainer.override = true;

            cleanupTimer.interval = duration_secs * 1000;
            cleanupTimer.restart();
        }
    }

    Timer {
        id: cleanupTimer
        onTriggered: root.mainBarContainer.override = false
    }

    function sendNotification(summary: string, body: string) {
        Quickshell.execDetached(["notify-send", "-a", "cshell", summary, body]);
    }
}
