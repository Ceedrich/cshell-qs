pragma Singleton

import Quickshell
import QtQuick

import Quickshell.Services.UPower

import qs.config
import qs.widgets
import qs.utils

Singleton {
    id: root
    enum BatteryStatus {
        Normal,
        Low,
        Critical,
        Charging
    }

    readonly property var _iconsCharging: ["󰢜", "󰂇", "󰢝", "󰢞", "󰂅"]
    readonly property var _iconsDischarging: ["󰁺", "󰁼", "󰁾", "󰂀", "󰂂", "󰁹"]

    readonly property UPowerDevice bat: UPower.displayDevice
    readonly property bool ready: bat.ready

    property int perc: bat.percentage * 100

    property Item batteryWarning: CText {
        text: `${root.icon} Battery ${root.batteryStatusString}...`
        color: root.batteryColor
    }

    onBatteryStatusChanged: if (root.batteryStatus !== BatteryService.Normal) {
        Qt.callLater(() => ShellService.showItem(batteryWarning));
    }

    readonly property int batteryStatus: {
        if (!ready) {
            return BatteryService.Normal;
        }
        if (!UPower.onBattery) {
            return BatteryService.Charging;
        }
        if (perc < 15) {
            return BatteryService.Critical;
        }
        if (perc < 30) {
            return BatteryService.Low;
        }
        return BatteryService.Normal;
    }

    readonly property color batteryColor: switch (batteryStatus) {
    case BatteryService.Charging:
        return Colors.green;
    case BatteryService.Critical:
        return Colors.red;
    case BatteryService.Low:
        return Colors.yellow;
    default:
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

    readonly property string batteryStatusString: {
        switch (batteryStatus) {
        case BatteryService.Normal:
            return "Normal";
        case BatteryService.Low:
            return "Low";
        case BatteryService.Critical:
            return "Critical";
        case BatteryService.Charging:
            return "Charging";
        default:
            return "[should not happen]";
        }
    }
}
