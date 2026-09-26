import QtQuick
import QtQuick.Layouts

import qs.config

Rectangle {
    enum Orientation {
        Horizontal,
        Vertical
    }

    property int orientation: CSeparator.Horizontal
    property real thickness: Config.border.width

    readonly property bool horizontal: orientation === CSeparator.Horizontal
    readonly property bool vertical: orientation === CSeparator.Vertical

    radius: Config.border.radius
    color: Colors.overlay2

    implicitWidth: vertical ? thickness : 0
    implicitHeight: horizontal ? thickness : 0

    Layout.preferredWidth: vertical ? thickness : 0
    Layout.preferredHeight: horizontal ? thickness : 0

    Layout.fillWidth: horizontal
    Layout.fillHeight: vertical
}
