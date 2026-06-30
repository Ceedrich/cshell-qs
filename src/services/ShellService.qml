pragma Singleton

import Quickshell

Singleton {
    id: root

    function sendNotification(summary: string, body: string) {
        Quickshell.execDetached(["notify-send", "-a", "cshell", summary, body]);
    }
}
