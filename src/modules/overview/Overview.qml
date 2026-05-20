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

    component DropWorkspace: Item {
        id: ws
        required property HyprlandWorkspace workspace
        property alias text: wsName.text

        implicitWidth: rect.implicitWidth
        implicitHeight: rect.implicitHeight

        Rectangle {
            id: rect
            implicitWidth: 200
            implicitHeight: 100

            color: Colors.base
            opacity: 0.9

            border.color: HyprlandService.isActiveWorkspace(ws.workspace?.id) ? Colors.accent : Colors.overlay1
            border.width: 2
            radius: Config.border.radius

            CText {
                id: wsName
                anchors.centerIn: parent
                text: ws.workspace.id
            }
        }

        Rectangle {
            id: bg
            anchors.fill: parent

            color: Colors.overlay2

            opacity: (droparea.containsDrag || dropmousearea.hovered) ? 0.3 : 0.0

            Behavior on opacity {
                NumberAnimation {
                    duration: Config.animationDuration.quick
                    easing.type: Config.animationEasingTypes.quick
                }
            }
        }

        DropArea {
            id: droparea
            anchors.fill: parent

            onDropped: function (drop: DragEvent) {
                if (drop.action === Qt.MoveAction) {
                    HyprlandService.moveWindowToWorkspace(ws.workspace?.id || "emptyn", drop.text);
                }
            }
        }

        MouseArea {
            id: dropmousearea
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor

            hoverEnabled: true

            property bool hovered
            onEntered: hovered = true
            onExited: hovered = false

            onClicked: {
                if (ws.workspace) {
                    HyprlandService.focusWorkspace(ws.workspace?.id || "emptyn");
                }
                root.overviewWindow.visible = false;
            }
        }
    }

    ColumnLayout {
        spacing: Config.spacing
        anchors.horizontalCenter: parent.horizontalCenter
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

        // CDivider {
        //     orientation: CDivider.Orientation.Horizontal
        //     Layout.fillWidth: true
        // }

        GridLayout {
            Layout.alignment: Qt.AlignHCenter
            rowSpacing: Config.spacing
            columnSpacing: Config.spacing

            Repeater {
                model: root.toplevels

                Item {
                    id: item
                    required property var modelData

                    implicitHeight: window.implicitHeight
                    implicitWidth: window.implicitWidth

                    MouseArea {
                        id: mouseArea
                        anchors.fill: parent
                        drag.target: draggable

                        cursorShape: Qt.OpenHandCursor

                        drag.onActiveChanged: if (drag.active) {
                            parent.grabToImage(function (result) {
                                draggable.Drag.imageSource = result.url;
                                draggable.Drag.active = true;
                            });
                        } else {
                            draggable.Drag.active = false;
                        }
                    }

                    Item {
                        id: draggable
                        anchors.fill: parent

                        Drag.hotSpot.x: width / 2
                        Drag.hotSpot.y: height / 2

                        Drag.supportedActions: Qt.MoveAction
                        Drag.dragType: Drag.Automatic
                        Drag.mimeData: {
                            "text/plain": item.modelData?.address || ""
                        }
                    }

                    ClippingRectangle {
                        id: window

                        implicitWidth: capture.width
                        implicitHeight: capture.height

                        color: "transparent"

                        Rectangle {
                            id: windowBg
                            anchors.fill: parent
                            color: Colors.overlay2
                            opacity: 0.3
                        }

                        radius: Config.border.radius
                        border.width: 2
                        border.color: Colors.text

                        CWindowCapture {
                            id: capture
                            anchors.centerIn: parent
                            visible: !draggable.Drag.active
                            window: item.modelData?.wayland

                            Connections {
                                target: root
                                function onVisibleChanged() {
                                    capture.captureFrame();
                                }
                            }
                        }
                    }
                }
            }
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
}
