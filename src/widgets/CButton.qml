pragma ComponentBehavior: Bound
import QtQuick

import qs.config

Item {
    id: root
    property alias text: content.text

    property alias mouseareaEnabled: mousearea.enabled
    property alias hoverEnabled: mousearea.hoverEnabled
    property bool scrollingEnabled: true
    property alias propagateComposedEvents: mousearea.propagateComposedEvents

    property bool eventsEnabled: true

    // Hoverarea/Background
    property real backgroundOffset: 4
    property real backgroundOffsetX: backgroundOffset
    property real backgroundOffsetY: backgroundOffset
    property alias backgroundColor: background.color

    // Text aliases
    property alias topPadding: content.topPadding
    property alias bottomPadding: content.bottomPadding
    property alias leftPadding: content.leftPadding
    property alias rightPadding: content.rightPadding

    property alias verticalAlignment: content.verticalAlignment
    property alias horizontalAlignment: content.horizontalAlignment

    property alias textColor: content.color
    property alias defaultColor: content.defaultColor

    property alias underline: content.underline
    property alias font: content.font

    property bool hovered: false

    signal clicked
    signal rightClicked
    signal middleClicked
    signal scrollX(delta: real)
    signal scrollY(delta: real)

    implicitWidth: content.implicitWidth
    implicitHeight: content.implicitHeight

    component BgRect: Rectangle {
        anchors.top: root.top
        anchors.left: root.left
        width: root.width + 2 * root.backgroundOffsetX
        height: root.height + 2 * root.backgroundOffsetY

        radius: Config.border.radius

        transform: [
            Translate {
                x: -root.backgroundOffsetX
                y: -root.backgroundOffsetY
            }
        ]
    }

    BgRect {
        id: background
        color: "transparent"
    }

    BgRect {
        id: hoverarea
        color: Colors.overlay2
        opacity: mousearea.pressed ? 0.3 : root.hovered ? 0.2 : 0.0
    }

    CText {
        id: content
        topPadding: 4
        bottomPadding: 4
        leftPadding: 8
        rightPadding: 8
        text: ""
    }

    MouseArea {
        id: mousearea
        anchors.fill: parent
        visible: enabled

        cursorShape: Qt.PointingHandCursor
        acceptedButtons: Qt.RightButton | Qt.LeftButton | Qt.MiddleButton

        hoverEnabled: true
        scrollGestureEnabled: true

        onEntered: root.hovered = true
        onExited: root.hovered = false

        onPressed: evt => {
            if (!root.eventsEnabled) {
                evt.accepted = false;
            }
        }

        onClicked: evt => _onClicked(evt)
        onWheel: evt => _onWheel(evt)

        function _onClicked(evt: MouseEvent) {
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
            if (!root.scrollingEnabled) {
                evt.accepted = false;
                return;
            }
            const deltaX = -evt.angleDelta.x * Config.scrollFactor;
            const deltaY = -evt.angleDelta.y * Config.scrollFactor;

            root.scrollX(deltaX);
            root.scrollY(deltaY);
        }
    }
}
