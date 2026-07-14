pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell.Services.Pipewire

import qs.widgets
import qs.widgets.icons
import qs.modules.controlcenter.modules
import qs.services

ColumnLayout {
    CText {
        text: "Control Center"
        font.bold: true
    }

    CStyledSlider {
        id: volumeSlider
        indicator: VolumeIcon {
            volume: VolumeService.volume
            implicitWidth: 20
            implicitHeight: 20
            color: volumeSlider.iconColor
        }
        icon: VolumeService.volumeIcon
        Layout.fillWidth: true
        value: VolumeService.volume
        onInteraction: v => {
            if (VolumeService.muted) {
                VolumeService.muted = false;
            }
            VolumeService.setVolume(v);
        }

        MouseArea {
            anchors.fill: volumeSlider
            acceptedButtons: Qt.RightButton
            onClicked: volumeStreams.expanded = !volumeStreams.expanded
        }
    }

    Repeater {
        id: volumeStreams
        property bool expanded: false

        model: expanded ? VolumeService.streams : []

        delegate: RowLayout {
            id: nodeslider
            spacing: 0
            required property PwNode modelData
            property PwNode node: modelData

            Item {
                implicitWidth: 20
            }

            CStyledSlider {
                // icon: VolumeService.getIcon(node)
                Layout.fillWidth: true
                indicator: Image {
                    width: 20
                    height: 20
                    source: `image://icon/${nodeslider.node?.properties["application.icon-name"] || (nodeslider.node?.name === "spotify" ? "spotify" : "audio-player")}`
                }
                value: nodeslider.node.audio.volume
                onInteraction: v => {
                    nodeslider.node.audio.volume = v;
                }
            }
        }
    }

    CStyledSlider {
        id: brightnessSlider
        indicator: BrightnessIcon {
            brightness: BrightnessService.percentage / 100.0
            implicitWidth: 20
            implicitHeight: 20
            color: brightnessSlider.iconColor
        }
        icon: BrightnessService.icon
        visible: BrightnessService.available
        Layout.fillWidth: true
        from: 0
        to: 100
        value: BrightnessService.percentage
        onInteraction: v => BrightnessService.setBrightness(v)
    }

    NotificationCenter {
        Layout.fillWidth: true
    }
}
