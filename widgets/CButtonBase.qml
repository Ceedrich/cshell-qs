pragma ComponentBehavior: Bound
import Quickshell.Widgets
import QtQuick

import qs.config

Item {
    id: root

    property alias content: content.child
    required property bool hovered
    required property bool pressed

    property bool disabled: false

    // Hoverarea/Background
    property real backgroundOffset: 4
    property real backgroundOffsetX: backgroundOffset
    property real backgroundOffsetY: backgroundOffset
    property alias backgroundColor: background.color

    implicitWidth: content.implicitWidth
    implicitHeight: content.implicitHeight

    BgRect {
        id: background
        color: "transparent"
    }

    BgRect {
        id: hoverarea
        color: Colors.overlay2
        opacity: root.pressed ? 0.3 : root.hovered ? 0.2 : 0.0
    }

    WrapperRectangle {
        id: content
        color: "transparent"
        width: parent.width
    }

    component BgRect: Rectangle {
        anchors.top: root.top
        anchors.left: root.left
        width: root.width + 2 * root.backgroundOffsetX
        height: root.height + 2 * root.backgroundOffsetY

        radius: Config.border.radius

        transform: [
            Translate {
                x: -root.backgroundOffsetX
                y: -root.backgroundOffsetY
            }
        ]

        Behavior on color {
            Config.ColorAnimationQuick {}
        }

        Behavior on opacity {
            Config.NumberAnimationQuick {}
        }
    }
}
