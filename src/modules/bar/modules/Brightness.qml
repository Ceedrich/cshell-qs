import QtQuick

import qs.utils
import qs.widgets
import qs.services

CText {
    property var icons: ["󱩎", "󱩎", "󱩏", "󱩐", "󱩑", "󱩒", "󱩓", "󱩔", "󱩕", "󱩖", "󰛨"]
    property var icon: Utils.select_from_list(BrightnessCtl.percentage / 100, icons)
    text: BrightnessCtl.percentage + "% " + icon

    underline: true
}
