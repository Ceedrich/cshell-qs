import Quickshell
import Quickshell.Wayland

import qs.config

PanelWindow {
    anchors.top: true
    anchors.right: true
    anchors.left: true
    anchors.bottom: true
    margins {
        top: Config.margin
        right: Config.margin
        bottom: Config.margin
        left: Config.margin
    }

    mask: Region {
        item: notifications
    }

    WlrLayershell.namespace: "cshell-notifications"
    WlrLayershell.layer: WlrLayer.Overlay

    color: "transparent"

    Notifications {
        id: notifications
        anchors.top: parent.top
        anchors.right: parent.right

        width: 360
    }
}
