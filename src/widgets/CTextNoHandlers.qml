import QtQuick

import qs.config

Text {
    id: root
    property color defaultColor: Colors.text
    property bool underline: false

    font.family: Config.fontFamily
    font.pixelSize: Config.fontSize

    color: defaultColor

    bottomPadding: Config.spacing / 2
    topPadding: Config.spacing / 2

    Rectangle {
        visible: root.underline
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        height: 1
        color: root.color
    }
}
