import QtQuick

import qs.utils
import qs.widgets
import qs.services

CText {
    property var icons: ["󱩎", "󱩎", "󱩏", "󱩐", "󱩑", "󱩒", "󱩓", "󱩔", "󱩕", "󱩖", "󰛨"]
    property var icon: Utils.select_from_list(ctl.percentage / 100, icons)
    text: ctl.percentage + "% " + icon

    underline: true

    BrightnessCtl {
        id: ctl
    }
}
