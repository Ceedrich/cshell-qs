import QtQuick

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

    Mpris {}

    WidgetsCenter {
        anchors.horizontalCenter: parent.horizontalCenter
        barWindow: root.window
    }
    WidgetsRight {
        anchors.right: parent.right
        barWindow: root.window
    }
}
