import Quickshell.Hyprland
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts

import qs.config
import qs.utils
import qs.widgets

WrapperMouseArea {
    RowLayout {
        id: workspaces
        Repeater {
            model: Hyprland.workspaces

            PlainText {
                id: ws
                required property HyprlandWorkspace modelData
                property var isActive: Hyprland.focusedWorkspace?.id === modelData.id
                property bool hovered: false

                padding: Config.spacing / 2
                text: modelData.name
                color: isActive ? Colors.accent : (modelData.urgent ? Colors.red : Colors.overlay1)

                underline: isActive

                MouseArea {
                    anchors.fill: parent
                    onClicked: () => Hyprland.dispatch(`workspace ${ws.modelData.id}`)
                    cursorShape: Qt.PointingHandCursor
                }
            }
        }

        function prev() {
            let idx = Hyprland.workspaces.indexOf(Hyprland.focusedWorkspace);
            idx = Utils.clamp(0, Hyprland.workspaces.values.length - 1, idx - 1);
            let new_ws = Hyprland.workspaces.values[idx];
            Hyprland.dispatch(`workspace ${new_ws.id}`);
        }
        function next() {
            let idx = Hyprland.workspaces.indexOf(Hyprland.focusedWorkspace);
            idx = Utils.clamp(0, Hyprland.workspaces.values.length - 1, idx + 1);
            let new_ws = Hyprland.workspaces.values[idx];
            Hyprland.dispatch(`workspace ${new_ws.id}`);
        }
    }

    onWheel: evt => _onWheel(evt)

    property real delta: 0

    function _onWheel(evt: WheelEvent): void {
        delta += evt.angleDelta.y * Config.scrollFactor * 0.1;
        if (delta <= -1) {
            workspaces.prev();
            delta += 1;
        }
        if (delta >= 1) {
            workspaces.next();
            delta -= 1;
        }
    }
}
