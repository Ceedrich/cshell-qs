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
            model: HyprlandService.workspaces

            CTextButton {
                id: ws
                required property HyprlandWorkspace modelData
                property var isActive: HyprlandService.isActiveWorkspace(modelData.id)

                scrollingEnabled: false

                leftPadding: Config.spacing / 2
                rightPadding: Config.spacing / 2

                text: modelData.name
                textColor: isActive ? Colors.accent : (modelData.urgent ? Colors.base : Colors.overlay1)
                backgroundColor: modelData.urgent ? Colors.red : "transparent"

                underline: isActive

                onClicked: HyprlandService.focusWorkspace(ws.modelData.id)
            }
        }
    }

    onWheel: evt => _onWheel(evt)

    property real delta: 0

    function _onWheel(evt: WheelEvent): void {
        delta += -evt.angleDelta.y * Config.scrollFactor * 0.1;
        if (delta <= -1) {
            HyprlandService.focusPreviousWorkspace();
            delta += 1;
        }
        if (delta >= 1) {
            HyprlandService.focusNextWorkspace();
            delta -= 1;
        }
    }
}
