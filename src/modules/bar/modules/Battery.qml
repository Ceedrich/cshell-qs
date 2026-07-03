import Quickshell.Services.UPower

import qs.config
import qs.utils
import qs.widgets

CBarItem {
    visible: bat.ready
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

    enabled: false

    text: perc + "% " + icon
    underline: true

    textColor: {
        if (!UPower.onBattery) {
            return Colors.green;
        }
        if (perc < 15) {
            return Colors.red;
        }
        if (perc < 30) {
            return Colors.yellow;
        }
        return defaultColor;
    }
}
