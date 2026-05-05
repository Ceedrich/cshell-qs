import QtQuick

import qs.utils
import qs.config
import qs.services
import qs.widgets

CText {
    property var icons: ["󱩎", "󱩎", "󱩏", "󱩐", "󱩑", "󱩒", "󱩓", "󱩔", "󱩕", "󱩖", "󰛨"]
    property var icon: Utils.select_from_list(ctl.percentage / 100, icons)
    text: ctl.percentage + "% " + icon

    BrightnessCtl {
        id: ctl
    }
}
