import QtQuick
import Quickshell.Widgets

import qs.config

Item {
    id: root
    /// One of `Qt.Unckecked`, `Qt.PartiallyChecked`, `Qt.Checked`
    property int checkState

    property int implicitSize

    implicitWidth: implicitSize
    implicitHeight: implicitSize

    WrapperRectangle {
        anchors.fill: parent
        color: Colors.base

        border.color: Colors.text
        border.width: Config.border.width
        radius: 2

        margin: 2

        Item {
            Rectangle {
                id: partiallyCheckedMarker
                visible: root.checkState === Qt.PartiallyChecked

                anchors.fill: parent
                color: Colors.text
            }

            CText {
                id: checkedMarker
                visible: root.checkState === Qt.Checked
                anchors.centerIn: parent
                text: "󰄬"
            }
        }
    }
}
