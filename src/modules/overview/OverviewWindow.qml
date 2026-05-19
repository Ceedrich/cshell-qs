import Quickshell
import Quickshell.Wayland

import QtQuick

PanelWindow {
    id: root
    anchors {
        left: true
        right: true
        top: true
        bottom: true
    }

    color: "transparent"

    exclusionMode: ExclusionMode.Ignore

    WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive

    Overview {
        anchors.fill: parent
        overviewWindow: root

        Component.onCompleted: {
            forceActiveFocus();
        }
    }
}
