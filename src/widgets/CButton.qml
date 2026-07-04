pragma ComponentBehavior: Bound
import QtQuick

import qs.config
import qs.services

CButtonBase {
    id: root
    property bool clickEnabled: true
    property bool leftClickEnabled: clickEnabled
    property bool rightClickEnabled: false
    property bool middleClickEnabled: false
    property bool doubleClickEnabled: false

    property alias scrollingEnabled: wheel.enabled
    property alias hoverEnabled: hover.enabled

    readonly property bool anyClickEnabled: clickEnabled || root.doubleClickEnabled || root.rightClickEnabled || root.leftClickEnabled || root.middleClickEnabled

    scrollingEnabled: false
    hoverEnabled: enabled && (anyClickEnabled || scrollingEnabled)
    pressed: tap.pressed
    hovered: hover.hovered

    // Hoverarea/Background
    signal clicked
    signal doubleClicked
    signal longHover
    signal rightClicked
    signal middleClicked
    signal scrollX(delta: real)
    signal scrollY(delta: real)

    TapHandler {
        id: tap
        enabled: root.anyClickEnabled
        gesturePolicy: TapHandler.ReleaseWithinBounds
        exclusiveSignals: root.doubleClickEnabled ? TapHandler.SingleTap | TapHandler.DoubleTap : TapHandler.SingleTap
        onTapped: (p, button) => {
            if (button === Qt.LeftButton || button == Qt.NoButton) /* touchscreen */ {
                root.clicked();
            }
            if (button === Qt.RightButton) {
                root.rightClicked();
            }
            if (button === Qt.MiddleButton) {
                root.middleClicked();
            }
        }

        onDoubleTapped: root.doubleClicked()
    }

    Timer {
        id: longHoverTimer
        interval: Config.longHoverTime
        onTriggered: root.longHover()
    }

    HoverHandler {
        id: hover
        onHoveredChanged: if (hovered)
            longHoverTimer.restart()
        cursorShape: root.anyClickEnabled ? Qt.PointingHandCursor : Qt.ArrowCursor
    }

    WheelHandler {
        id: wheel
        onWheel: e => _onWheel(e)

        acceptedDevices: PointerDevice.Mouse | PointerDevice.TouchPad

        function _onWheel(evt: WheelEvent) {
            const inverted = SettingsService.data.invertScrolling ? -1 : 1;
            const deltaX = inverted * evt.angleDelta.x * SettingsService.data.scrollFactor / 100;
            const deltaY = inverted * evt.angleDelta.y * SettingsService.data.scrollFactor / 100;

            root.scrollX(deltaX);
            root.scrollY(deltaY);
        }
    }
}
