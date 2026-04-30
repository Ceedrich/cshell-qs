import Quickshell.Hyprland
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts

RowLayout {

    // Repeater {
    //     model: 9
    //
    //     Text {
    //         id: ws
    //         required property int index
    //         property var ws: Hyprland.workspaces.values.find(w => w.id === index + 1)
    //         property bool isActive: Hyprland.focusedWorkspace?.id === (index + 1)
    //         text: index + 1
    //         color: isActive ? 'purple' : 'gray'
    //
    //         MouseArea {
    //             anchors.fill: parent
    //             onClicked: Hyprland.dispatch("workspace " + (ws.index + 1))
    //         }
    //     }
    // }

    Repeater {
        model: Hyprland.workspaces

        Text {
            id: ws
            required property HyprlandWorkspace modelData
            property var isActive: Hyprland.focusedWorkspace?.id === modelData.id

            text: modelData.name
            color: isActive ? "green" : (modelData.urgent ? "red" : "gray")

            MouseArea {
                anchors.fill: parent
                onClicked: Hyprland.dispatch("workspace " + (ws.modelData.id))
            }
        }
    }
}
