import QtQuick

import qs.utils
import qs.widgets
import qs.services

CBarItem {
    visible: BrightnessService.available
    property var icons: ["󱩎", "󱩎", "󱩏", "󱩐", "󱩑", "󱩒", "󱩓", "󱩔", "󱩕", "󱩖", "󰛨"]
    property var icon: Utils.select_from_list(BrightnessService.percentage / 100, icons)
    text: BrightnessService.percentage + "% " + icon

    underline: true

    clickEnabled: false
    scrollingEnabled: true

    onScrollY: delta => BrightnessService.percentage = Utils.clamp(0, 100, BrightnessService.percentage + delta)
}
