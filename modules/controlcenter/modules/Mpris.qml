import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import Quickshell.Widgets

import qs.config
import qs.widgets
import qs.services

WrapperRectangle {
    id: root
    radius: Config.border.radius
    color: Colors.surface2
    margin: Config.spacing

    visible: MprisService.available

    ColumnLayout {
        ClippingRectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: root.width / 2
            radius: 5

            Image {
                anchors.fill: parent
                source: MprisService.imageUrl
                fillMode: Image.PreserveAspectCrop
                horizontalAlignment: Image.AlignHCenter
                verticalAlignment: Image.AlignVCenter

                layer.enabled: true
                layer.effect: MultiEffect {
                    blurEnabled: true
                    blur: 2.0
                }
            }

            Image {
                anchors.fill: parent
                source: MprisService.imageUrl
                fillMode: Image.PreserveAspectFit
                horizontalAlignment: Image.AlignHCenter
                verticalAlignment: Image.AlignVCenter
            }
        }
        CText {
            text: `${MprisService.title} - ${MprisService.album}`
            Layout.fillWidth: true
        }

        CSlider {
            id: slider
            visible: MprisService.progressAvailable

            Layout.fillWidth: true
            value: MprisService.player?.position || 0
            from: 0
            to: MprisService.player?.length || 0
            interactionOnMove: false
            onInteraction: v => MprisService.player.position = v

            FrameAnimation {
                running: slider.visible
                onTriggered: () => MprisService.player.positionChanged()
            }
        }

        RowLayout {
            Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom

            CTextButton {
                text: "󰒮"
                font.pixelSize: Config.font.textPixelSize * 1.75
                onClicked: MprisService.previous()
            }
            CTextButton {
                text: MprisService.isPlaying ? "󰏤" : "󰐊"
                font.pixelSize: Config.font.textPixelSize * 1.75
                onClicked: MprisService.togglePlaying()
            }
            CTextButton {
                text: "󰒭"
                font.pixelSize: Config.font.textPixelSize * 1.75
                onClicked: MprisService.next()
            }
        }
    }
}
