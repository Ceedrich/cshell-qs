pragma Singleton
import Quickshell
import QtQuick
import Quickshell.Services.Notifications

import qs.modules.notifications

Singleton {
    id: root
    readonly property ListModel history: ListModel {}

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

    Component {
        id: notificationComponent
        NotificationData {}
    }
}
