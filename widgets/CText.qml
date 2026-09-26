import QtQuick

import qs.config

Text {
    id: root
    property color defaultColor: Colors.text
    property color mutedColor: Colors.overlay2
    property bool underline: false
    property bool muted: false

    font.family: Config.font.familyMono
    font.pixelSize: Config.font.textPixelSize

    color: muted ? mutedColor : defaultColor

    elide: Qt.ElideRight

    Rectangle {
        id: spacer
        anchors.top: parent.baseline
        height: 8
    }

    Rectangle {
        visible: root.underline
        anchors.left: root.left
        anchors.right: root.right
        anchors.bottom: spacer.bottom

        height: 1
        color: root.color
    }
}
