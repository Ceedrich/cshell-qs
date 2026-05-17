import QtQuick

import qs.config

// TODO: migrate with CButton

Item {
    id: root
    property alias mouseareaEnabled: mousearea.enabled

    property string text: ""
    property bool underline: false

    property color defaultColor: Colors.text
    property color textColor: defaultColor

    // Spacing properties
    property alias padding: content.padding
    property alias topPadding: content.topPadding
    property alias bottomPadding: content.bottomPadding
    property alias leftPadding: content.leftPadding
    property alias rightPadding: content.rightPadding

    property alias backgroundOffset: background.offset
    property alias backgroundOffsetX: background.offsetX
    property alias backgroundOffsetY: background.offsetY

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
        property int offset: 5
        property int offsetX: offset
        property int offsetY: offset

        anchors.top: root.top
        anchors.left: root.left
        width: root.width + 2 * offsetX
        height: root.height + 2 * offsetY

        radius: 100

        transform: [
            Translate {
                x: -background.offsetX
                y: -background.offsetY
            }
        ]

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
        visible: enabled

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
