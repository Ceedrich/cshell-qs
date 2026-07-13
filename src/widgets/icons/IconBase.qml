import QtQuick

import qs.config

Item {
    property color color: Colors.text
    property color strokeColor: color
    property color fillColor: color

    implicitWidth: 200
    implicitHeight: 200

    property int strokeWidth: 8

    // qmlformat off
    Behavior on color { CAnim {} }
    Behavior on fillColor { CAnim {} }
    Behavior on strokeColor { CAnim {} }
    // qmlformat on

    component CAnim: ColorAnimation {
        duration: 100
    }
}
