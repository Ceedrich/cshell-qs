import Quickshell.Hyprland
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts

import qs.config
import qs.services
import qs.widgets

WrapperMouseArea {
    RowLayout {
        id: workspaces
        Repeater {
            model: Hyprland.workspaces

            CText {
                id: ws
                required property HyprlandWorkspace modelData
                property var isActive: WorkspacesService.isActive(modelData)
                property bool hovered: false

                padding: Config.spacing / 2
                text: modelData.name
                color: isActive ? Colors.accent : (modelData.urgent ? Colors.red : Colors.overlay1)

                underline: isActive

                MouseArea {
                    anchors.fill: parent
                    onClicked: () => WorkspacesService.focus(ws.modelData)
                    cursorShape: Qt.PointingHandCursor
                }
            }
        }
    }

    onWheel: evt => _onWheel(evt)

    property real delta: 0

    function _onWheel(evt: WheelEvent): void {
        delta += evt.angleDelta.y * Config.scrollFactor * 0.1;
        if (delta <= -1) {
            WorkspacesService.prev();
            delta += 1;
        }
        if (delta >= 1) {
            WorkspacesService.next();
            delta -= 1;
        }
    }
}
