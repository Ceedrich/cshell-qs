pragma ComponentBehavior: Bound
import QtQuick

import qs.config
import qs.services

CButtonBase {
    id: root
    property bool clickEnabled: true
    property bool leftClickEnabled: true
    property bool rightClickEnabled: false
    property bool middleClickEnabled: false

    property bool scrollingEnabled: false

    property alias mouseareaEnabled: mousearea.enabled
    property alias hoverEnabled: mousearea.hoverEnabled
    property alias propagateComposedEvents: mousearea.propagateComposedEvents

    hoverEnabled: enabled

    pressed: mousearea.pressed
    hovered: false

    // Hoverarea/Background
    signal clicked
    signal longHover
    signal rightClicked
    signal middleClicked
    signal scrollX(delta: real)
    signal scrollY(delta: real)

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
