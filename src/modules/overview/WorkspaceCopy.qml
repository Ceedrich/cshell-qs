pragma ComponentBehavior: Bound

import Quickshell.Hyprland
import Quickshell.Wayland
import Quickshell.Widgets
import QtQuick

import qs.config
import qs.widgets

Item {
    id: root
    property HyprlandWorkspace focusedWS: Hyprland.focusedWorkspace

    property real windowScale: 0.5
    property var toplevels: focusedWS?.toplevels.values || []

    onFocusedWSChanged: {
        onWorkspaceUpdate();
        update();
    }
    onToplevelsChanged: update()

    implicitWidth: focusedWS?.monitor.width * windowScale
    implicitHeight: focusedWS?.monitor.height * windowScale

    signal update
    signal onWorkspaceUpdate

    onUpdate: Hyprland.refreshToplevels()

    Repeater {
        model: root.toplevels

        delegate: Item {
            id: item
            required property var modelData
            readonly property HyprlandToplevel toplevel: modelData

            x: toplevel.lastIpcObject.at?.[0] * root.windowScale
            y: toplevel.lastIpcObject.at?.[1] * root.windowScale
            implicitWidth: toplevel.lastIpcObject.size?.[0] * root.windowScale
            implicitHeight: toplevel.lastIpcObject.size?.[1] * root.windowScale

            WrapperItem {
                id: bg
                anchors.fill: parent

                margin: 5

                ClippingRectangle {
                    id: iteminner
                    anchors.fill: parent
                    color: "transparent"
                    radius: Config.border.radius
                    border.width: Config.border.width
                    border.color: Colors.text

                    Rectangle {
                        id: bgrect
                        anchors.fill: parent
                        color: Colors.base
                        opacity: 0.8
                    }

                    Item {
                        id: dragitem
                        anchors.fill: parent

                        Drag.supportedActions: Qt.MoveAction
                        Drag.dragType: Drag.Automatic
                        Drag.mimeData: {
                            "text/plain": item.modelData?.address || ""
                        }
                    }

                    MouseArea {
                        id: dragarea
                        anchors.fill: parent
                        drag.target: dragitem
                        cursorShape: Qt.OpenHandCursor

                        drag.onActiveChanged: if (drag.active) {
                            let item;
                            if (capture.hasContent) {
                                item = capture;
                            } else {
                                item = no_caputre;
                            }
                            item.grabToImage(function (result) {
                                dragitem.Drag.imageSource = result.url;
                                dragitem.Drag.active = true;
                            });
                        } else {
                            dragitem.Drag.active = false;
                        }
                    }

                    Rectangle {
                        id: no_caputre
                        visible: !capture.hasContent && !dragarea.drag.active
                        anchors.fill: parent
                        color: Colors.base

                        CText {
                            anchors.centerIn: parent
                            textFormat: Text.RichText
                            horizontalAlignment: Qt.AlignCenter
                            text: `<b>${item.toplevel.title || ""}</b><br/>[No Preview Available]`
                        }
                    }

                    ScreencopyView {
                        id: capture
                        enabled: visible
                        visible: !dragarea.drag.active
                        anchors.fill: parent
                        captureSource: item.modelData.wayland
                        live: true
                    }
                }
            }
        }
    }
}
