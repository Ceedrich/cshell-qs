import QtQuick

import qs.config

MouseArea {
    acceptedButtons: Qt.NoButton
    scrollGestureEnabled: true

    signal previous
    signal next

    onWheel: evt => _onWheel(evt)

    property real delta: 0

    function _onWheel(evt: WheelEvent): void {
        delta += -evt.angleDelta.y * Config.scrollFactor * 0.1;
        if (delta <= -1) {
            previous();
            delta += 1;
        }
        if (delta >= 1) {
            next();
            delta -= 1;
        }
    }
}
