import qs.config
import qs.widgets
import qs.services

CBarItem {
    visible: BatteryService.ready
    enabled: false

    text: BatteryService.percentageText + BatteryService.icon

    underline: true

    textColor: BatteryService.batteryColor === Colors.text ? defaultColor : BatteryService.batteryColor
}
