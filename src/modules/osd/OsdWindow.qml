import Quickshell
import Quickshell.Wayland
import QtQuick

import qs.config
import qs.services

PanelWindow { // qmllint disable uncreatable-type
    id: root
    anchors.top: true
    anchors.right: true
    margins.top: Config.margin // qmllint disable unqualified unresolved-type
    margins.right: Config.margin // qmllint disable unqualified unresolved-type

    WlrLayershell.namespace: "cshell-osd"

    exclusionMode: ExclusionMode.Normal

    color: "transparent"

    mask: Region {
        item: osd
        intersection: Intersection.Xor
    }

    implicitHeight: osd.implicitHeight
    implicitWidth: osd.implicitWidth

    Binding {
        target: OsdService
        property: "osd"
        value: osd
    }

    Osd {
        id: osd
    }
}
