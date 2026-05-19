pragma ComponentBehavior: Bound
import QtQuick

import qs.config

CButton {
    id: root
    property alias text: content.text

    // Text aliases
    property alias topPadding: content.topPadding
    property alias bottomPadding: content.bottomPadding
    property alias leftPadding: content.leftPadding
    property alias rightPadding: content.rightPadding

    property alias verticalAlignment: content.verticalAlignment
    property alias horizontalAlignment: content.horizontalAlignment

    property color textColor: defaultColor
    property alias defaultColor: content.defaultColor

    property alias underline: content.underline
    property alias font: content.font

    content: CText {
        id: content
        topPadding: 4
        bottomPadding: 4
        leftPadding: 8
        rightPadding: 8
        text: ""
        color: root.disabled ? Colors.overlay1 : root.textColor
    }
}
