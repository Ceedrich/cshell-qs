import Quickshell
import Quickshell.Wayland

import qs.config

PanelWindow {
    anchors.top: true
    anchors.right: true
    margins {
        top: Config.margin
        right: Config.margin
    }

    WlrLayershell.namespace: "cshell-notifications"

    implicitWidth: 360
    implicitHeight: notifications.implicitHeight

    color: "transparent"

    Notifications {
        id: notifications
    }
}
