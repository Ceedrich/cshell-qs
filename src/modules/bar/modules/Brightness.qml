import QtQuick

import qs.utils
import qs.widgets
import qs.config
import qs.services

CText {
    property var icons: ["󱩎", "󱩎", "󱩏", "󱩐", "󱩑", "󱩒", "󱩓", "󱩔", "󱩕", "󱩖", "󰛨"]
    property var icon: Utils.select_from_list(BrightnessCtl.percentage / 100, icons)
    text: BrightnessCtl.percentage + "% " + icon

    underline: true

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onWheel: wheel => {
            const delta = -wheel.angleDelta.y * Config.scrollFactor;
            const clamp = (low, high, value) => Math.min(Math.max(value, low), high);
            BrightnessCtl.percentage = clamp(0, 100, BrightnessCtl.percentage + delta);
        }
    }
}
