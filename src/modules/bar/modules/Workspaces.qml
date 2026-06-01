import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

import qs.config
import qs.services
import qs.widgets

Item {
    implicitWidth: workspaces.implicitWidth
    implicitHeight: workspaces.implicitHeight

    CDiscreteScrollMouseArea {
        anchors.fill: parent
        onPrevious: HyprlandService.focusPreviousWorkspace()
        onNext: HyprlandService.focusNextWorkspace()
    }

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
}
