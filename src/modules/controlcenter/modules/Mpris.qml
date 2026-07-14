import QtQuick
import QtQuick.Layouts
import Quickshell.Widgets

import qs.config
import qs.widgets
import qs.services

WrapperRectangle {
    id: root
    radius: Config.border.radius
    color: Colors.surface2
    margin: Config.spacing

    ColumnLayout {
        ClippingRectangle {
            Layout.preferredWidth: root.width / 2
            Layout.preferredHeight: root.width / 2
            radius: 5

            Image {
                anchors.fill: parent
                source: MprisService.imageUrl
            }
        }
        CText {
            text: `${MprisService.title} - ${MprisService.album}`
            Layout.fillWidth: true
        }
        RowLayout {
            Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom

            CTextButton {
                text: "󰒮"
            }
            CTextButton {
                text: "󰏤"
            }
            CTextButton {
                text: "󰒭"
            }
        }
    }
}
