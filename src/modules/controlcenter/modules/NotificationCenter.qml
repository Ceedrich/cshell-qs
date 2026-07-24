import QtQuick
import QtQuick.Layouts

import qs.widgets
import qs.config
import qs.services
import qs.modules.notifications.widgets

ColumnLayout {
    RowLayout {
        CText {
            text: "Notifications"
            font.bold: true
            font.pixelSize: Config.font.headingPixelSize
        }

        Item {
            Layout.fillWidth: true
        }

        CTextButton {
            visible: NotificationService.notifications.length > 0
            text: "clear all"
            onClicked: NotificationService.clearAll()
        }
    }

    CText {
        visible: NotificationService.notifications.length == 0
        text: "[no notifications]"
    }

    Repeater {
        model: NotificationService.notifications

        delegate: CNotification {
            Layout.fillWidth: true
            required property var modelData
            notification: modelData

            onClicked: notification.dismiss()
        }
    }
}
