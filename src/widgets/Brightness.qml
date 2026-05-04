import QtQuick
import qs.config

import "../services"

Text {
    property var icons: ["󱩎", "󱩎", "󱩏", "󱩐", "󱩑", "󱩒", "󱩓", "󱩔", "󱩕", "󱩖", "󰛨"]
    property var icon: icons[Math.floor(ctl.percentage / icons.length)]
    text: ctl.percentage + "% " + icon
    color: Colors.text

    BrightnessCtl {
        id: ctl
    }
}
