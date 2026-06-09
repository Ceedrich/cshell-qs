import QtQuick
import QtQuick.Layouts
import Quickshell

import qs.config
import qs.modules.bar.modules

Rectangle {
    id: root

    required property QtObject window

    anchors.left: parent.left
    anchors.right: parent.right
    anchors.top: parent.top
    anchors.margins: Config.margin

    implicitHeight: Config.barHeight

    color: "transparent"

    readonly property Region regionMask: Region {
        intersection: Intersection.Subtract

        Region {
            item: left
        }
        Region {
            item: center
        }
        Region {
            item: right
        }
    }

    Mpris {
        id: left
    }

    WidgetsCenter {
        id: center
        anchors.horizontalCenter: parent.horizontalCenter
        barWindow: root.window
    }
    WidgetsRight {
        id: right
        anchors.right: parent.right
        barWindow: root.window
    }
}
