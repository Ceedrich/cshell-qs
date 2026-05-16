import Quickshell
import Quickshell.Wayland
import QtQuick

import qs.modules.bar

PanelWindow {
    id: root

    WlrLayershell.namespace: "cshell"
    WlrLayershell.layer: WlrLayer.Top

    mask: Region {
        x: 0
        y: 0
        width: root.width
        height: root.height
        intersection: Intersection.Xor

        regions: [barRegion]

        Region {
            id: barRegion
            item: bar

            intersection: Intersection.Subtract
        }
    }

    color: "transparent"

    exclusionMode: ExclusionMode.Ignore

    anchors {
        top: true
        left: true
        right: true
        bottom: true
    }

    Bar {
        id: bar
        window: root
    }
}
