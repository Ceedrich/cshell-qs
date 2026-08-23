import Quickshell
import Quickshell.Wayland
import QtQuick

import qs.config

PanelWindow {
    id: root

    WlrLayershell.namespace: "cshell-bar"
    WlrLayershell.layer: WlrLayer.Top

    mask: Region {
        x: 0
        y: 0
        width: root.width
        height: root.height
        intersection: Intersection.Xor

        regions: [bar.regionMask]
    }

    color: "transparent"

    exclusionMode: ExclusionMode.Normal
    exclusiveZone: Config.barHeight

    anchors {
        top: true
        left: true
        right: true
        bottom: false
    }

    implicitHeight: screen.height

    Bar {
        id: bar
        window: root
    }
}
