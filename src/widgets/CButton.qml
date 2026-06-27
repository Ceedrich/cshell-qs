pragma ComponentBehavior: Bound
import Quickshell.Widgets
import QtQuick

import qs.config
import qs.services

Item {
    id: root

    property alias content: content.child

    property bool disabled: false

    property bool clickEnabled: true
    property bool leftClickEnabled: true
    property bool rightClickEnabled: false
    property bool middleClickEnabled: false

    property bool scrollingEnabled: false

    property alias mouseareaEnabled: mousearea.enabled
    property alias hoverEnabled: mousearea.hoverEnabled
    property alias propagateComposedEvents: mousearea.propagateComposedEvents

    hoverEnabled: enabled

    // Hoverarea/Background
    property real backgroundOffset: 4
    property real backgroundOffsetX: backgroundOffset
    property real backgroundOffsetY: backgroundOffset
    property alias backgroundColor: background.color

    property bool hovered: false

    signal clicked
    signal longHover
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

        Behavior on color {
            Config.ColorAnimationQuick {}
        }

        Behavior on opacity {
            Config.NumberAnimationQuick {}
        }
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

    WrapperRectangle {
        id: content
        color: "transparent"
        width: parent.width
    }

    Timer {
        id: longHoverTimer
        interval: Config.longHoverTime
        onTriggered: root.longHover()
    }

    MouseArea {
        id: mousearea
        anchors.fill: parent
        enabled: !root.disabled
        visible: enabled

        cursorShape: Qt.PointingHandCursor
        acceptedButtons: {
            let ret = Qt.NoButton;
            // qmlformat off
            if (!root.clickEnabled) return ret;
            if (root.rightClickEnabled) ret |= Qt.RightButton;
            if (root.leftClickEnabled) ret |= Qt.LeftButton;
            if (root.middleClickEnabled) ret |= Qt.MiddleButton;
            // qmlformat on
            return ret;
        }

        scrollGestureEnabled: true

        onEntered: {
            root.hovered = true;
            longHoverTimer.running = true;
        }
        onExited: {
            root.hovered = false;
            longHoverTimer.running = false;
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
            const inverted = SettingsService.data.invertScrolling ? -1 : 1;
            const deltaX = inverted * evt.angleDelta.x * SettingsService.data.scrollFactor / 100;
            const deltaY = inverted * evt.angleDelta.y * SettingsService.data.scrollFactor / 100;

            root.scrollX(deltaX);
            root.scrollY(deltaY);
        }
    }
}
