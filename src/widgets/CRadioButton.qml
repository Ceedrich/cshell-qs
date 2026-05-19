import Quickshell.Widgets
import QtQuick

import qs.config

Item {
    id: root
    /// One of `Qt.Unckecked`, `Qt.PartiallyChecked`, `Qt.Checked`
    property bool checked

    property int implicitSize

    implicitWidth: implicitSize
    implicitHeight: implicitSize

    WrapperRectangle {
        anchors.fill: parent
        color: Colors.base

        border.color: Colors.text
        border.width: Config.border.width
        radius: 1000

        margin: 2

        Rectangle {
            id: partiallyCheckedMarker
            visible: root.checked

            radius: 1000

            color: Colors.text
        }
    }
}
