import QtQuick
import QtQuick.Layouts
import Quickshell.Services.Mpris

import qs.widgets
import qs.config

GridLayout {
    id: root
    required property MprisPlayer player
    required property QtObject popup

    columnSpacing: Config.spacing

    Image {
        Layout.alignment: Qt.AlignHCenter
        Layout.preferredWidth: 100
        Layout.preferredHeight: 100

        source: root.player.trackArtUrl

        TapHandler {
            onTapped: () => {
                root.popup.visible = false;
                root.player.raise();
            }
        }
        HoverHandler {
            cursorShape: hovered && Qt.PointingHandCursor
        }
    }

    ColumnLayout {

        visible: root.player != null
        Layout.alignment: Qt.AlignVCenter
        spacing: 0

        CText {
            font: titleText.font
            text: titleText.elidedText

            ElidedText {
                id: titleText
                text: root.player?.trackTitle || ""
                font.pixelSize: Config.fontSize * 1.25
            }
        }

        PlainText {
            text: artistText.elidedText

            ElidedText {
                id: artistText
                text: root.player?.trackArtist || ""
            }
        }

        PlainText {
            text: albumText.elidedText

            ElidedText {
                id: albumText
                text: root.player?.trackAlbum || ""
            }
        }

        TapHandler {
            onTapped: () => {
                root.popup.visible = false;
                root.player.raise();
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
            onClicked: () => root.player.previous()
        }

        CText {
            text: root.player?.isPlaying ? "󰏤" : "󰐊"
            font.pixelSize: Config.fontSize * 1.25
            onClicked: () => root.player.togglePlaying()
        }

        CText {
            text: "󰒭"
            font.pixelSize: Config.fontSize * 1.25
            onClicked: () => root.player.next()
        }
    }

    CSlider {
        id: slider
        Layout.fillWidth: true
        visible: root.player?.positionSupported && root.player?.lengthSupported && root.player?.canSeek
        value: root.player.position
        from: 0
        to: root.player.length
        onMoved: () => root.player.position = value

        FrameAnimation {
            running: slider.visible
            onTriggered: () => root.player.positionChanged()
        }
    }

    component ElidedText: TextMetrics {
        elideWidth: Config.maxMprisWidth
        elide: Qt.ElideRight
    }
}
