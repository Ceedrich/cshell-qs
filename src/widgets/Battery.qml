import Quickshell.Services.UPower
import QtQuick
import QtQuick.Layouts

import qs.config
import qs.utils

RowLayout {
    Text {
        property var iconsCharging: ["󰢜", "󰂇", "󰢝", "󰢞", "󰂅"]
        property var iconsDischarging: ["󰁺", "󰁼", "󰁾", "󰂀", "󰂂", "󰁹"]

        property UPowerDevice bat: UPower.displayDevice
        property int perc: bat.percentage * 100
        property var icon: {
            if (UPower.onBattery) {
                return Utils.select_from_list(bat.percentage, iconsDischarging);
            } else {
                return Utils.select_from_list(bat.percentage, iconsCharging);
            }
        }

        text: perc + "% " + icon
        color: {
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
    }
}
