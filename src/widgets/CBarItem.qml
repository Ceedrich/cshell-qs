import QtQuick
import Quickshell.Widgets

import qs.config

Item {
    id: root

    property string text: ""
    property bool underline: false

    property color defaultColor: Colors.text
    property color textColor: defaultColor

    property bool hovered: false

    implicitWidth: content.implicitWidth
    implicitHeight: content.implicitHeight

    signal clicked
    signal rightClicked
    signal middleClicked
    signal scrollX(delta: real)
    signal scrollY(delta: real)

    Rectangle {
        id: background
        anchors.fill: root
        radius: 100

        color: root.hovered ? Colors.overlay1 : "transparent"
        opacity: mousearea.pressed ? 0.3 : 0.2

        Behavior on color {
            ColorAnimation {
                easing.type: Easing.InOutQuad
                duration: 200
            }
        }
    }

    CText {
        id: content
        anchors.fill: root

        color: root.textColor

        text: root.text
        underline: root.underline
    }

    MouseArea {
        id: mousearea
        anchors.fill: root

        cursorShape: Qt.PointingHandCursor
        acceptedButtons: Qt.RightButton | Qt.LeftButton | Qt.MiddleButton

        scrollGestureEnabled: true
        hoverEnabled: true

        onEntered: root.hovered = true
        onExited: root.hovered = false

        onClicked: evt => _onClicked(evt)
        onWheel: evt => _onWheel(evt)

        function _onClicked(evt: MouseEvent): void {
            if (evt.button === Qt.LeftButton) {
                root.clicked();
            }
            if (evt.button === Qt.RightButton) {
                root.rightClicked();
            }
            if (evt.button === Qt.MiddleButton) {
                root.middleClicked();
            }
        }

        function _onWheel(evt: WheelEvent) {
            const deltaX = -evt.angleDelta.x * Config.scrollFactor;
            const deltaY = -evt.angleDelta.y * Config.scrollFactor;

            root.scrollX(deltaX);
            root.scrollY(deltaY);
        }
    }
}
