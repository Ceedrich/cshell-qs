import Quickshell
import Quickshell.Wayland

import qs.config

PanelWindow {
    id: root

    WlrLayershell.namespace: "cshell-bar-exclusion-zone"

    anchors {
        top: true
        left: true
        right: true
    }

    margins {
        top: Config.margin
        right: Config.margin
        left: Config.margin
    }

    mask: Region {
        x: 0
        y: 0
        width: root.width
        height: root.height
        intersection: Intersection.Subtract
    }

    color: "transparent"

    implicitHeight: Config.barHeight
}
