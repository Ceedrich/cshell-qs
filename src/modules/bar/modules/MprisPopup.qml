import QtQuick
import QtQuick.Layouts

import qs.services
import qs.widgets
import qs.config

GridLayout {
    id: root
    width: Config.mprisPopupWidth
    required property QtObject popup

    columnSpacing: Config.spacing

    Image {
        Layout.alignment: Qt.AlignHCenter
        Layout.preferredWidth: 100
        Layout.preferredHeight: 100

        source: MprisService.trackArtUrl

        TapHandler {
            onTapped: () => {
                root.popup.visible = false;
                MprisService.raise();
            }
        }
        HoverHandler {
            cursorShape: hovered && Qt.PointingHandCursor
        }
    }

    ColumnLayout {
        visible: MprisService.available
        Layout.alignment: Qt.AlignVCenter
        spacing: 0

        CText {
            Layout.fillWidth: true

            text: MprisService.title
            font.pixelSize: Config.fontSize * 1.25
        }

        CText {
            Layout.fillWidth: true

            text: MprisService.artist
        }

        CText {
            Layout.fillWidth: true

            text: MprisService.album
        }

        TapHandler {
            onTapped: () => {
                root.popup.visible = false;
                MprisService.raise();
            }
        }
        HoverHandler {
            cursorShape: hovered && Qt.PointingHandCursor
        }
    }

    RowLayout {
        Layout.row: 1
        Layout.alignment: Qt.AlignHCenter
        spacing: Config.spacing

        CButton {
            text: "󰒮"

            onClicked: MprisService.previous()
        }

        CButton {
            text: MprisService.isPlaying ? "󰏤" : "󰐊"
            onClicked: MprisService.togglePlaying()
        }

        CButton {
            text: "󰒭"
            onClicked: MprisService.next()
        }
    }

    RowLayout {
        id: positionDisplay
        visible: MprisService.progressAvailable

        CSlider {
            id: slider
            Layout.fillWidth: true
            value: MprisService.player?.position || 0
            from: 0
            to: MprisService.player?.length || 0
            onMoved: () => MprisService.player.position = value

            FrameAnimation {
                running: slider.visible
                onTriggered: () => MprisService.player.positionChanged()
            }
        }

        CText {
            text: root.formatMinutes(MprisService.player?.position || 0)
        }
    }

    CComboBox {
        visible: MprisService.players.length > 1

        onActivated: i => MprisService.setPlayer(MprisService.players[i])

        enabled: visible
        Layout.row: 2
        Layout.columnSpan: 2
        Layout.alignment: Qt.AlignHCenter
        model: MprisService.players.map(p => p.identity)
    }

    function formatMinutes(seconds: real): string {
        const m = String(Math.floor(seconds / 60)).padStart(2, '0');
        const s = String(Math.floor(seconds % 60)).padStart(2, '0');

        return `${m}:${s}`;
    }
}
