import Quickshell
import Quickshell.Wayland

import QtQuick

import qs.config

PanelWindow {
    id: root
    anchors {
        left: true
        right: true
        top: true
        bottom: true
    }

    color: "transparent"

    visible: false

    exclusionMode: ExclusionMode.Ignore

    WlrLayershell.namespace: "cshell-overview"
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive

    Overview {
        anchors.fill: parent
        anchors.margins: Config.spacing
        overviewWindow: root

        Component.onCompleted: {
            forceActiveFocus();
        }
    }
}
