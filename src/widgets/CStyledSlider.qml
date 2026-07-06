import QtQuick
import Quickshell.Widgets

import qs.config

CSliderBase {
    id: root
    property int size: 50
    property string icon: "󰋽"
    property color iconColor: Colors.blue

    implicitWidth: horizontal ? 2 * size : size
    implicitHeight: horizontal ? size : 2 * size

    contentItem: ClippingRectangle {
        anchors.fill: parent
        radius: 1000
        color: root.bgColor

        Rectangle {
            id: fill
            anchors.left: root.horizontal ? parent.left : undefined
            anchors.bottom: root.vertical ? parent.bottom : undefined
            implicitHeight: root.horizontal ? root.height : root.height * root.pos
            implicitWidth: root.vertical ? root.width : root.width * root.pos
            color: root.fgColor
        }

        Text {
            text: root.icon
            color: root.iconColor

            anchors.bottom: root.vertical ? parent.bottom : undefined
            anchors.left: root.horizontal ? parent.left : undefined

            anchors.horizontalCenter: root.vertical ? parent.horizontalCenter : undefined
            anchors.verticalCenter: root.horizontal ? parent.verticalCenter : undefined

            anchors.margins: Config.spacing
        }

        // CText {
        //     anchors.verticalCenter: root.horizontal ? root.verticalCenter : undefined
        //     anchors.horizontalCenter: root.verticalCenter ? root.horizontalCenter : undefined
        //     text: root.icon
        //     color: "red"
        //     anchors.left: root.horizontal ? root.left : undefined
        //     anchors.bottom: root.vertical ? root.bottom : undefined
        // }
    }
}
