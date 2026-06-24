import Quickshell

import qs.config

PanelWindow {
    anchors.top: true
    anchors.right: true
    margins {
        top: Config.margin
        right: Config.margin
    }

    implicitWidth: 360
    implicitHeight: notifications.implicitHeight

    color: "transparent"

    Notifications {
        id: notifications
    }
}
