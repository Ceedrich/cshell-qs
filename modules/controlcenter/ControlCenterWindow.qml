import Quickshell
import Quickshell.Hyprland
import Quickshell.Widgets
import QtQuick

import qs.config
import qs.services

PanelWindow {
    id: root
    visible: false

    readonly property bool isOpen: visible

    anchors {
        top: true
        right: true
    }
    margins {
        top: Config.margin
        right: Config.margin
    }

    color: "transparent"

    implicitWidth: 360
    implicitHeight: wrapper.implicitHeight

    WrapperRectangle {
        id: wrapper
        color: Colors.base
        border.color: Colors.overlay2
        border.width: Config.border.width
        radius: Config.border.radius
        width: parent.width

        margin: Config.spacing

        ControlCenter {
            onFocusChanged: console.log("focus:", focus)
            onActiveFocusChanged: console.log("active focus:", activeFocus)
        }
    }

    Binding {
        target: ShellService
        property: "controlCenterWindow"
        value: root
    }

    Binding {
        when: root.isOpen
        target: OsdService
        property: "enabled"
        value: false
    }

    HyprlandFocusGrab {
        windows: [root]
        active: root.visible
        onCleared: root.visible = false
    }

    function toggleOpen() {
        visible = !visible;
    }
}
