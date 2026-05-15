import QtQuick

import qs.utils
import qs.widgets
import qs.config
import qs.services

CBarItem {
    property var icons: ["󱩎", "󱩎", "󱩏", "󱩐", "󱩑", "󱩒", "󱩓", "󱩔", "󱩕", "󱩖", "󰛨"]
    property var icon: Utils.select_from_list(BrightnessService.percentage / 100, icons)
    text: BrightnessService.percentage + "% " + icon

    underline: true

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onWheel: wheel => {
            const delta = -wheel.angleDelta.y * Config.scrollFactor;
            const clamp = (low, high, value) => Math.min(Math.max(value, low), high);
            BrightnessService.percentage = clamp(0, 100, BrightnessService.percentage + delta);
        }
    }
}
