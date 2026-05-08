import Quickshell
import Quickshell.Widgets
import QtQuick

import qs.config

PopupWindow {
    id: root
    required property Item barItem
    default required property Item child

    anchor.item: barItem
    anchor.rect.y: parentWindow?.height || barItem.height
    anchor.rect.x: barItem.width / 2 - width / 2

    grabFocus: true

    color: "transparent"

    implicitWidth: rect.implicitWidth
    implicitHeight: rect.implicitHeight

    WrapperRectangle {
        id: rect
        border.color: Colors.overlay1
        border.width: 0.5
        radius: 32

        color: Colors.base

        WrapperRectangle {
            color: "transparent"
            margin: Config.spacing
            leftMargin: 2 * Config.spacing
            rightMargin: 2 * Config.spacing

            children: [root.child]
        }
    }
}
