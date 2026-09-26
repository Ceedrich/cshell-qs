import QtQuick

import qs.widgets
import qs.services

CBarItem {
    visible: BrightnessService.available
    text: BrightnessService.percentage + "% " + BrightnessService.icon

    underline: true

    clickEnabled: false
    scrollingEnabled: true

    onScrollY: delta => BrightnessService.increaseBrightness(delta)
}
