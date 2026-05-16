import QtQuick
import QtQuick.Layouts

import Quickshell

import qs.widgets
import qs.services
import qs.config

BarPill {
    visible: MprisService.available
    enabled: visible
    RowLayout {
        id: rootItem
        CBarItem {
            id: textRoot

            Layout.maximumWidth: Config.maxMprisWidth
            readonly property string icon: MprisService.playerIcon

            text: textRoot.formatText()
            textColor: Colors.overlay1

            function formatText(): string {
                return `${icon} ${MprisService.title} - ${MprisService.artist}`;
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
