import Quickshell.Services.Mpris
import QtQuick.Layouts
import QtQuick

import qs.widgets
import qs.config

ColumnLayout {
    id: root
    spacing: 0
    required property MprisPlayer player
    required property QtObject popup
    visible: player != null

    function openApp() {
        player.dbusName;
    }

    CText {
        visible: text != null
        Layout.alignment: Qt.AlignHCenter
        text: root.player?.trackTitle || ""

        onClicked: () => {
            root.player.raise();
            root.popup.visible = false;
        }
    }

    PlainText {
        visible: text != null
        Layout.alignment: Qt.AlignHCenter
        text: root.player?.trackArtist || ""
    }

    PlainText {
        visible: text != null
        Layout.alignment: Qt.AlignHCenter
        text: root.player?.trackAlbum || ""
    }

    RowLayout {
        Layout.alignment: Qt.AlignHCenter
        spacing: Config.spacing

        CText {
            text: "󰒮"
            onClicked: () => root.player.previous()
        }

        CText {
            text: root.player?.isPlaying ? "󰏤" : "󰐊"
            onClicked: () => root.player.togglePlaying()
        }

        CText {
            text: "󰒭"
            onClicked: () => root.player.next()
        }
    }
}
