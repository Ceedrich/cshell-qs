pragma Singleton
import Quickshell
import QtQuick
import Quickshell.Services.Notifications

import qs.modules.notifications
import qs.services

Singleton {
    id: root
    property list<NotificationData> allNotifs: []
    property list<NotificationData> notifications: allNotifs.filter(n => !n.dismissed)
    readonly property list<NotificationData> onScreenNotifications: notifications.filter(n => !n.hidden)

    NotificationServer {
        id: notificationServer
        bodySupported: true
        actionsSupported: true
        imageSupported: true
        keepOnReload: false

        onNotification: n => {
            n.tracked = true;

            const notif = notificationComponent.createObject(root, {
                n,
                hidden: ShellService.controlCenterWindow.isOpen
            });
            root.allNotifs = [notif, ...root.notifications];
        }
    }

    Timer {
        running: root.notifications.length > 0
        interval: 5000
        repeat: true
        onTriggered: {
            for (const n of root.notifications) {
                n.updateTimeString();
            }
        }
    }

    function clearAll() {
        for (const n of notifications) {
            n.dismiss();
        }
        allNotifs = [];
    }

    function hideAll() {
        for (const n of onScreenNotifications) {
            n.hide();
        }
    }

    Component {
        id: notificationComponent
        NotificationData {}
    }
}
