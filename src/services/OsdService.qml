pragma Singleton

import Quickshell
import QtQuick

import qs.modules.osd
import qs.utils

Singleton {
    id: root

    property bool enabled: true

    property Osd osd

    property string label: ""
    property string secondaryLabel: ""
    property real value: .7

    function setRange(value: real, label = "", secondaryLabel = "", from = 0, to = 1) {
        if (!enabled) {
            return;
        }

        root.value = Utils.clamp(0, 1, (value - from) / (to - from));
        root.label = label;
        root.secondaryLabel = secondaryLabel;

        root.osd.type = Osd.Range;
        hideTimer.restart();
    }

    Timer {
        id: hideTimer
        interval: 2000
        onTriggered: root.osd.type = Osd.None
    }
}
