pragma Singleton
import Quickshell
import QtQuick
import Quickshell.Services.Notifications

import qs.modules.notifications

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
                n
            });
            root.allNotifs = [notif, ...root.notifications];
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
