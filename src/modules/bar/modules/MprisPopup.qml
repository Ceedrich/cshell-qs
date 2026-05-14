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

        source: Mpris.trackArtUrl

        TapHandler {
            onTapped: () => {
                root.popup.visible = false;
                Mpris.raise();
            }
        }
        HoverHandler {
            cursorShape: hovered && Qt.PointingHandCursor
        }
    }

    ColumnLayout {
        visible: Mpris.available
        Layout.alignment: Qt.AlignVCenter
        spacing: 0

        CTextNoHandlers {
            id: title
            Layout.fillWidth: true
            text: titleText.elidedText
            font.pixelSize: Config.fontSize * 1.25

            TextMetrics {
                id: titleText
                font: title.font
                text: Mpris.title
                elideWidth: title.width
                elide: Qt.ElideRight
            }
        }

        PlainText {
            id: artist
            text: artistText.elidedText
            Layout.fillWidth: true

            TextMetrics {
                id: artistText
                font: artist.font
                text: Mpris.artist
                elideWidth: artist.width
                elide: Qt.ElideRight
            }
        }

        PlainText {
            id: album
            text: albumText.elidedText

            Layout.fillWidth: true
            TextMetrics {
                id: albumText
                font: album.font
                text: Mpris.album
                elideWidth: album.width
                elide: Qt.ElideRight
            }
        }

        TapHandler {
            onTapped: () => {
                root.popup.visible = false;
                Mpris.raise();
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

        CText {
            text: "󰒮"
            font.pixelSize: Config.fontSize * 1.25
            onClicked: () => Mpris.previous()
        }

        CText {
            text: Mpris.isPlaying ? "󰏤" : "󰐊"
            font.pixelSize: Config.fontSize * 1.25
            onClicked: () => Mpris.togglePlaying()
        }

        CText {
            text: "󰒭"
            font.pixelSize: Config.fontSize * 1.25
            onClicked: () => Mpris.next()
        }
    }

    RowLayout {
        id: positionDisplay
        visible: Mpris.progressAvailable

        CSlider {
            id: slider
            Layout.fillWidth: true
            value: Mpris.player?.position || 0
            from: 0
            to: Mpris.player?.length || 0
            onMoved: () => Mpris.player.position = value

            FrameAnimation {
                running: slider.visible
                onTriggered: () => Mpris.player.positionChanged()
            }
        }

        CText {
            text: root.formatMinutes(Mpris.player?.position || 0)
        }
    }

    CComboBox {
        visible: Mpris.players.length > 1

        onActivated: i => Mpris.setPlayer(Mpris.players[i])

        enabled: visible
        Layout.row: 2
        Layout.columnSpan: 2
        Layout.alignment: Qt.AlignHCenter
        model: Mpris.players.map(p => p.identity)
    }

    function formatMinutes(seconds: real): string {
        const m = String(Math.floor(seconds / 60)).padStart(2, '0');
        const s = String(Math.floor(seconds % 60)).padStart(2, '0');

        return `${m}:${s}`;
    }
}
