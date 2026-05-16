import QtQuick

import qs.config

Item {
    id: root
    property string text: ""
    property bool hovered: false

    signal clicked

    implicitWidth: content.implicitWidth
    implicitHeight: content.implicitHeight

    Rectangle {
        id: background
        anchors.fill: parent

        color: Colors.overlay1

        radius: Config.border.radius

        opacity: mousearea.pressed ? 0.3 : root.hovered ? 0.2 : 0.0
    }

    CText {
        id: content
        topPadding: 4
        bottomPadding: 4
        leftPadding: 8
        rightPadding: 8
        text: root.text
    }

    MouseArea {
        id: mousearea
        anchors.fill: parent

        cursorShape: Qt.PointingHandCursor

        hoverEnabled: true
        scrollGestureEnabled: true

        onEntered: root.hovered = true
        onExited: root.hovered = false

        onClicked: evt => _onClicked(evt)

        function _onClicked(evt: MouseEvent) {
            if (evt.button === Qt.LeftButton) {
                root.clicked();
            }
        }
    }
}
