import Quickshell.Services.UPower
import QtQuick
import QtQuick.Layouts

import qs.config

RowLayout {
    Text {
        property var iconsCharging: ["󰢜", "󰂇", "󰢝", "󰢞", "󰂅"]
        property var iconsDischarging: ["󰁺", "󰁼", "󰁾", "󰂀", "󰂂", "󰁹"]

        property UPowerDevice bat: UPower.displayDevice
        property int perc: bat.percentage * 100
        property var icon: {
            if (UPower.onBattery) {
                var num = bat.percentage * iconsDischarging.length;
                num = Math.floor(num);
                return iconsDischarging[num];
            } else {
                var num = bat.percentage * iconsCharging.length;
                num = Math.round(num);
                return iconsCharging[num];
            }
        }

        text: perc + "% " + icon
        color: {
            if (!UPower.onBattery) {
                return Style.green;
            }
            if (perc < 15) {
                return Style.red;
            }
            if (perc < 30) {
                return Style.yellow;
            }
            return Style.text;
        }
    }
}
