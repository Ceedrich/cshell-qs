import QtQuick
import QtQuick.Layouts

import qs.services
import qs.widgets
import qs.config

GridLayout {
    id: root
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
            text: titleText.elidedText
            font.pixelSize: Config.fontSize * 1.25

            ElidedText {
                id: titleText
                font: title.font
                text: Mpris.title
            }
        }

        PlainText {
            id: artist
            text: artistText.elidedText

            ElidedText {
                id: artistText
                font: artist.font
                text: Mpris.artist
            }
        }

        PlainText {
            id: album
            text: albumText.elidedText

            ElidedText {
                id: albumText
                font: album.font
                text: Mpris.album
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

    function formatMinutes(seconds: real): string {
        const m = String(Math.floor(seconds / 60)).padStart(2, '0');
        const s = String(Math.floor(seconds % 60)).padStart(2, '0');

        return `${m}:${s}`;
    }

    component ElidedText: TextMetrics {
        elideWidth: Config.maxMprisWidth
        elide: Qt.ElideRight
    }
}
