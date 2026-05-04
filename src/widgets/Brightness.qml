import QtQuick
import qs.config
import qs.utils
import qs.services

Text {
    property var icons: ["󱩎", "󱩎", "󱩏", "󱩐", "󱩑", "󱩒", "󱩓", "󱩔", "󱩕", "󱩖", "󰛨"]
    property var icon: Utils.select_from_list(ctl.percentage / 100, icons)
    text: ctl.percentage + "% " + icon
    color: Colors.text

    BrightnessCtl {
        id: ctl
    }
}
