import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

import qs.config
import qs.widgets

RowLayout {
    Repeater {
        model: Hyprland.workspaces

        CText {
            id: ws
            required property HyprlandWorkspace modelData
            property var isActive: Hyprland.focusedWorkspace?.id === modelData.id
            property bool hovered: false

            padding: Config.spacing / 2
            text: modelData.name
            color: isActive ? Colors.accent : (modelData.urgent ? Colors.red : Colors.overlay1)

            onClicked: () => Hyprland.dispatch(`workspace ${ws.modelData.id}`)
        }
    }
}
