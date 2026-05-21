pragma ComponentBehavior: Bound

import Quickshell.Hyprland
import Quickshell.Widgets
import QtQuick

import qs.widgets
import qs.config

Rectangle {
    id: root
    property HyprlandWorkspace focusedWS: Hyprland.focusedWorkspace
    property real windowScale: 0.5
    property var toplevels: focusedWS?.toplevels.values || []

    onToplevelsChanged: blub()
    onFocusedWSChanged: blub()

    signal blub

    onBlub: Hyprland.refreshToplevels()

    implicitWidth: focusedWS?.monitor.width / 2 || null
    implicitHeight: focusedWS?.monitor.height / 2 || null

    color: "transparent"

    Repeater {
        model: root.toplevels

        delegate: Item {
            id: item
            required property var modelData
            readonly property HyprlandToplevel toplevel: modelData

            Connections {
                target: root
                function onBlub() {
                    item.x = item.toplevel.lastIpcObject.at?.[0] * root.windowScale;
                    item.y = item.toplevel.lastIpcObject.at?.[1] * root.windowScale;
                    item.width = item.toplevel.lastIpcObject.size?.[0] * root.windowScale;
                    item.height = item.toplevel.lastIpcObject.size?.[1] * root.windowScale;
                }
            }

            x: toplevel.lastIpcObject.at?.[0] * root.windowScale
            y: toplevel.lastIpcObject.at?.[1] * root.windowScale
            width: toplevel.lastIpcObject.size?.[0] * root.windowScale
            height: toplevel.lastIpcObject.size?.[1] * root.windowScale

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

                Drag.supportedActions: Qt.MoveAction
                Drag.dragType: Drag.Automatic
                Drag.mimeData: {
                    "text/plain": item.modelData?.address || ""
                }
            }

            ClippingRectangle {
                id: window

                anchors.fill: parent

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
                    anchors.fill: parent
                    visible: !draggable.Drag.active
                    window: item.modelData?.wayland

                    live: true

                    // Connections {
                    //     target: root
                    //     function onBlub() {
                    //         console.log("capture");
                    //         Qt.callLater(() => capture.captureFrame());
                    //     }
                    // }
                }
            }
        }
    }
}
