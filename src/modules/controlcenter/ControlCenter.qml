import QtQuick
import QtQuick.Layouts

import qs.widgets
import qs.config
import qs.modules.controlcenter.modules
import qs.services

ColumnLayout {
    CText {
        text: "Control Center"
        font.bold: true
    }

    GridLayout {
        Layout.fillWidth: true
        columns: 2

        CTextButton {
            text: VolumeService.volumeIcon
            onClicked: VolumeService.toggleMuted()
            textColor: VolumeService.muted ? Colors.overlay2 : Colors.text
        }

        CSlider {
            Layout.fillWidth: true
            value: VolumeService.volume
            onInteraction: v => VolumeService.setVolume(v)
        }

        Repeater {
            id: volumeControls
            property bool expanded: false
        }

        CText {
            visible: BrightnessService.available
            text: "Brightness"
        }

        CSlider {
            visible: BrightnessService.available
            Layout.fillWidth: true
            from: 0
            to: 100
            value: BrightnessService.percentage
            onInteraction: v => BrightnessService.setBrightness(v)
        }
    }

    NotificationCenter {
        Layout.fillWidth: true
    }
}
