import QtQuick

import qs.utils
import qs.widgets
import qs.services

CBarItem {
    property var icons: ["󱩎", "󱩎", "󱩏", "󱩐", "󱩑", "󱩒", "󱩓", "󱩔", "󱩕", "󱩖", "󰛨"]
    property var icon: Utils.select_from_list(BrightnessService.percentage / 100, icons)
    text: BrightnessService.percentage + "% " + icon

    underline: true

    clickingEnabled: false

    onScrollY: delta => BrightnessService.percentage = Utils.clamp(0, 100, BrightnessService.percentage + delta)
}
