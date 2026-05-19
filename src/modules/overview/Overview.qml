pragma ComponentBehavior: Bound

import Quickshell.Hyprland
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

    ColumnLayout {
        width: parent.width
        RowLayout {
            Layout.alignment: Qt.AlignHCenter
            Repeater {
                model: root.worskpaces

                Item {
                    id: ws
                    required property HyprlandWorkspace modelData
                    implicitWidth: rect.implicitWidth
                    implicitHeight: rect.implicitHeight

                    Rectangle {
                        id: rect
                        implicitWidth: 200
                        implicitHeight: 100

                        color: Colors.base
                        opacity: 0.9

                        CText {
                            anchors.centerIn: parent
                            text: ws.modelData.id
                        }
                    }

                    Rectangle {
                        id: bg
                        anchors.fill: parent

                        color: Colors.overlay2

                        opacity: droparea.containsDrag ? 0.3 : 0.0

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
                                const address = drop.text;
                                WorkspacesService.moveWindowToWorkspace(ws.modelData, address);
                            }
                        }
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            WorkspacesService.focus(ws.modelData);
                            root.overviewWindow.visible = false;
                        }
                    }
                }
            }
        }

        GridLayout {
            Layout.alignment: Qt.AlignHCenter
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

                        cursorShape: Qt.PointingHandCursor

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

                    CWindowCapture {
                        id: window
                        window: item.modelData?.wayland
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
