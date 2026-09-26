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
    Keys.onPressed: function (event: KeyEvent) {
        if (event.key === Qt.Key_R) {
            workspace.resetPosition();
        }
    }

    Connections {
        target: root.overviewWindow
        function onVisibleChanged() {
            workspace.update();
            workspace.resetPosition();
        }
    }

    property var toplevels: Hyprland.focusedWorkspace?.toplevels.values || []
    property var worskpaces: HyprlandService.workspaces

    Rectangle {
        id: background
        anchors.fill: parent

        color: Colors.base
        opacity: 0.3
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: Config.spacing

        Item {
            Layout.alignment: Qt.AlignHCenter
            implicitWidth: dropspaces.implicitWidth
            implicitHeight: dropspaces.implicitHeight

            CDiscreteScrollMouseArea {
                anchors.fill: parent
                onNext: HyprlandService.focusNextWorkspace()
                onPrevious: HyprlandService.focusPreviousWorkspace()
            }

            RowLayout {
                id: dropspaces
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
        }
        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true

            MouseArea {
                cursorShape: drag.active ? Qt.ClosedHandCursor : Qt.ArrowCursor
                anchors.fill: parent
                drag.target: workspace
                onClicked: root.overviewWindow.visible = false
                onWheel: evt => {
                    const delta = evt.angleDelta.y * Config.scrollFactor * 0.01;
                    workspace.scale *= Math.exp(delta);
                }
            }

            WorkspaceCopy {
                id: workspace
                x: parent.width / 2 - width / 2
                y: 0

                onOpenApp: function (address: string) {
                    HyprlandService.focusWindow(address);
                    handler.close();
                }

                Behavior on x {
                    Config.NumberAnimationSimple {}
                }

                Behavior on y {
                    Config.NumberAnimationSimple {}
                }

                NumberAnimation {
                    id: resetScaleAnimation
                    running: false
                    target: workspace
                    property: "scale"
                    duration: 400
                    easing.type: Easing.OutQuad
                    to: 1
                }

                function resetPosition() {
                    resetScaleAnimation.running = true;
                    x = parent.width / 2 - width / 2;
                    y = 0;
                }
            }
        }
    }

    IpcHandler {
        id: handler
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
                    HyprlandService.focusWorkspace(ws.workspace?.id || "emptyn");
                    root.overviewWindow.visible = false;
                }
            }
        }
    }
}
