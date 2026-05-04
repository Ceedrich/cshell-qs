import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

import qs.config

RowLayout {
    Repeater {
        model: Hyprland.workspaces

        Text {
            id: ws
            required property HyprlandWorkspace modelData
            property var isActive: Hyprland.focusedWorkspace?.id === modelData.id

            text: modelData.name
            color: isActive ? Colors.accent : (modelData.urgent ? Colors.red : Colors.overlay0)

            MouseArea {
                anchors.fill: parent
                onClicked: Hyprland.dispatch("workspace " + (ws.modelData.id))
            }
        }
    }
}
