import QtQuick
import QtQuick.Layouts

import qs.config
import qs.services
import qs.modules.notifications.widgets

ColumnLayout {
    id: onScreenCol

    spacing: Config.spacing

    Repeater {
        model: NotificationService.onScreenNotifications

        delegate: COnscreenNotification {
            required property var modelData
            notification: modelData
        }
    }
}
