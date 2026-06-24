import QtQuick
import Quickshell.Services.Notifications

import qs.config

QtObject {
    id: root
    property bool isNew: true
    property bool hidden: false

    property bool dismissed: false

    property bool shouldExpire: false

    property date time: new Date()
    property string timeString: "now"

    readonly property string summary: n?.summary || ""
    readonly property string body: n?.body || ""
    readonly property string image: n?.image || n?.appIcon || ""
    readonly property string appName: n?.appName || n?.desktopEntry || ""

    readonly property bool isCritical: n?.urgency === NotificationUrgency.Critical

    default property Notification n

    readonly property Timer updateStringTimer: Timer {
        running: !root.dismissed
        interval: 5000
        repeat: true
        onTriggered: root.updateTimeString()
    }

    readonly property Timer expireTimer: Timer {
        running: !root.dismissed
        interval: (root.n?.expireTimeout > 0) ? root.n.expireTimeout : Config.notificationDismissTimeout
        onTriggered: root.shouldExpire = true
    }

    function dismiss() {
        if (!dismissed) {
            dismissed = true;
            n?.dismiss();
        }
    }

    function hide() {
        hidden = true;
    }

    function updateTimeString() {
        const diffMs = Date.now() - time.getTime();
        const diffMinutes = diffMs / 60_000;
        if (diffMinutes < 1) {
            const diffSeconds = diffMs / 1000;
            timeString = `${diffSeconds}s ago`;
        } else {
            timeString = `${Math.floor(diffMinutes)}m ago`;
        }
    }

    readonly property Connections c: Connections {
        target: root.n
        function onClosed() {
            root.dismiss();
        }
    }
}
