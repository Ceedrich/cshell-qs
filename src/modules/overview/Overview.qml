pragma ComponentBehavior: Bound

import Quickshell.Hyprland
import Quickshell.Widgets
import Quickshell.Io
import QtQuick
import QtQuick.Layouts

import qs.config
import qs.widgets
import qs.services

Item {
    id: root

    required property QtObject overviewWindow
    Keys.onEscapePressed: overviewWindow.visible = false

    Connections {
        target: root.overviewWindow
        function onVisibleChanged() {
            workspace.update();
        }
    }

    property var toplevels: Hyprland.focusedWorkspace?.toplevels.values || []
    property var worskpaces: Hyprland.workspaces?.values || []

    Rectangle {
        id: background
        anchors.fill: parent

        color: Colors.base
        opacity: 0.3

        MouseArea {
            anchors.fill: parent
            onClicked: root.overviewWindow.visible = false
        }
    }

    ColumnLayout {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        spacing: Config.spacing

        RowLayout {
            Layout.alignment: Qt.AlignHCenter
            spacing: Config.spacing
            Repeater {
                model: root.worskpaces

                DropWorkspace {
                    required property var modelData
                    workspace: modelData
                }
            }
            DropWorkspace {
                workspace: null
                text: "+"
            }
        }
        WorkspaceCopy {
            id: workspace
        }
    }

    IpcHandler {
        target: "overview"
        function open(): void {
            root.overviewWindow.visible = true;
        }
        function close(): void {
            root.overviewWindow.visible = false;
        }
        function toggle(): void {
            root.overviewWindow.visible = !root.overviewWindow.visible;
        }
    }

    component DropWorkspace: WrapperRectangle {
        id: ws
        required property HyprlandWorkspace workspace
        property alias text: wsName.text

        color: Colors.base
        opacity: 0.9

        border.color: HyprlandService.isActiveWorkspace(ws.workspace?.id) ? Colors.accent : Colors.overlay1
        border.width: 2
        radius: Config.border.radius

        CDropZone {
            implicitWidth: 200
            implicitHeight: 100

            CText {
                id: wsName
                anchors.centerIn: parent
                text: ws.workspace?.id || "[id]"
            }

            onDropped: function (drop: DragEvent) {
                if (drop.action === Qt.MoveAction) {
                    HyprlandService.moveWindowToWorkspace(ws.workspace?.id || "emptyn", drop.text);
                }
            }

            MouseArea {
                id: dropmousearea
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor

                onClicked: {
                    if (ws.workspace) {
                        HyprlandService.focusWorkspace(ws.workspace?.id || "emptyn");
                    }
                    root.overviewWindow.visible = false;
                }
            }
        }
    }
}
