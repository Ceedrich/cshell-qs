import QtQuick
import QtQuick.Layouts

import qs.config
import qs.modules.notifications

Item {
    id: root
    required property NotificationData notification

    Layout.fillWidth: true
    implicitHeight: n.implicitHeight

    ParallelAnimation {
        running: n.notification.isNew
        onFinished: n.notification.isNew = false

        // qmlformat off
        Config.NumberAnimationSimple { target: n; property: "opacity"; from: 0; to: 1 }
        Config.NumberAnimationSimple { target: n; property: "x"; from: 200; to: 0 }
        // qmlformat on
    }

    ParallelAnimation {
        id: hideAnimaiton
        running: n.notification.shouldExpire

        // qmlformat off
        Config.NumberAnimationSimple { target: n; property: "opacity"; from: 1; to: 0 }
        Config.NumberAnimationSimple { target: n; property: "x"; from: 0; to: -200 }
        // qmlformat on
        onFinished: n.notification.hidden = true
    }

    ParallelAnimation {
        id: dismissAnimation
        running: false

        // qmlformat off
        Config.NumberAnimationSimple { target: n; property: "opacity"; from: 1; to: 0 }
        Config.NumberAnimationSimple { target: n; property: "x"; from: 0; to: -200 }
        // qmlformat on
        onFinished: n.notification.dismiss()
    }

    CNotification {
        id: n
        width: root.width
        notification: root.notification

        onShouldDismiss: dismissAnimation.running = true
    }
}
