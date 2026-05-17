import QtQuick
import QtQuick.Layouts

import Quickshell
import Quickshell.Widgets

import qs.widgets
import qs.services
import qs.config

BarPill {
    visible: MprisService.available
    enabled: visible
    RowLayout {
        id: rootItem
        spacing: Config.spacing
        ClippingRectangle {
            Layout.preferredWidth: 20
            Layout.preferredHeight: 20
            radius: 6
            color: "transparent"

            CText {
                anchors.centerIn: parent
                text: MprisService.playerIcon
            }
            Image {
                anchors.centerIn: parent
                width: 20
                height: 20
                source: MprisService.trackArtUrl
            }
        }

        CBarItem {
            id: textRoot

            Layout.maximumWidth: Config.maxMprisWidth

            text: textRoot.formatText()
            textColor: Colors.overlay1

            function formatText(): string {
                return `${MprisService.title} - ${MprisService.artist}`;
            }

            onClicked: playerPopup.visible = !playerPopup.visible
            onRightClicked: MprisService.togglePlaying()
        }

        BarPopup {
            id: playerPopup
            barItem: rootItem

            anchor.rect.x: 0

            MprisPopup {
                popup: playerPopup
            }
        }
    }
}
