pragma ComponentBehavior: Bound

import QtQuick
import Quickshell.Widgets

import qs.config

CSliderBase {
    id: root
    property int size: 50

    property string icon: "󰋽"
    property color activeIconColor: Colors.base

    readonly property color iconColor: indicatorLoader.pos > pos ? fgColor : activeIconColor

    implicitWidth: horizontal ? 2 * size : size
    implicitHeight: horizontal ? size : 2 * size

    property Component indicator: CText {
        text: root.icon
        color: root.iconColor
    }

    contentItem: ClippingRectangle {
        id: content
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

        Loader {
            id: indicatorLoader

            property real pos: (anchors.margins + (root.horizontal ? width : height)) / (root.horizontal ? root.width : root.height)

            anchors.bottom: root.vertical ? parent.bottom : undefined
            anchors.left: root.horizontal ? parent.left : undefined

            anchors.horizontalCenter: root.vertical ? parent.horizontalCenter : undefined
            anchors.verticalCenter: root.horizontal ? parent.verticalCenter : undefined

            anchors.margins: Config.spacing

            sourceComponent: root.indicator
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
