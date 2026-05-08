import QtQuick
import QtQuick.Controls.Basic

import qs.config

Slider {
    id: slider
    value: 0.5

    background: Rectangle {
        x: slider.leftPadding
        y: slider.topPadding + slider.availableHeight / 2 - height / 2
        implicitWidth: 200
        implicitHeight: 4
        width: slider.availableWidth
        height: implicitHeight
        radius: 2
        color: Colors.overlay1

        Rectangle {
            width: slider.visualPosition * parent.width
            height: parent.height
            color: Colors.accent
            radius: 2
        }
    }

    handle: Rectangle {
        x: slider.leftPadding + slider.visualPosition * (slider.availableWidth - width)
        y: slider.topPadding + slider.availableHeight / 2 - height / 2
        implicitWidth: Config.spacing * 1.5
        implicitHeight: Config.spacing * 1.5
        radius: Config.spacing * 2
        color: Colors.text
        border.color: Colors.overlay1
    }
}
