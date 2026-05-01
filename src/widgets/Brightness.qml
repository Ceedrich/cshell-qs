import QtQuick

import "../services"

Text {
    property var icons: ["󱩎", "󱩎", "󱩏", "󱩐", "󱩑", "󱩒", "󱩓", "󱩔", "󱩕", "󱩖", "󰛨"]
    property var icon: icons[Math.floor(ctl.percentage / icons.length)]
    text: ctl.percentage + "% " + icon

    BrightnessCtl {
        id: ctl
    }
}
