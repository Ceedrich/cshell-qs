pragma Singleton

import Quickshell
import QtQuick

import Quickshell.Services.UPower

import qs.config
import qs.utils

Singleton {
    readonly property var _iconsCharging: ["󰢜", "󰂇", "󰢝", "󰢞", "󰂅"]
    readonly property var _iconsDischarging: ["󰁺", "󰁼", "󰁾", "󰂀", "󰂂", "󰁹"]

    readonly property UPowerDevice bat: UPower.displayDevice
    readonly property bool ready: bat.ready

    property int perc: bat.percentage * 100

    readonly property color batteryColor: {
        if (!UPower.onBattery) {
            return Colors.green;
        }
        if (perc < 15) {
            return Colors.red;
        }
        if (perc < 30) {
            return Colors.yellow;
        }
        return Colors.text;
    }

    readonly property string percentageText: perc + "% "
    readonly property string icon: {
        if (UPower.onBattery) {
            return Utils.select_from_list(bat.percentage, _iconsDischarging);
        } else {
            return Utils.select_from_list(bat.percentage, _iconsCharging);
        }
    }
}
