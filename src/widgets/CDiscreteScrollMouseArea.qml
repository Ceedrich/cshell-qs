import QtQuick

import qs.services

MouseArea {
    id: root
    acceptedButtons: Qt.NoButton
    scrollGestureEnabled: true

    signal previous
    signal next

    onWheel: evt => _onWheel(evt)

    property real delta: 0

    Timer {
        id: activeTimer
        running: false
        interval: 100
        onTriggered: root.delta = 0
    }

    function _onWheel(evt: WheelEvent): void {
        activeTimer.restart();
        delta += -evt.angleDelta.y * SettingsService.data.scrollFactor * 0.1;

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
