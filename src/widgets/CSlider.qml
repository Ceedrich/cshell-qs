import QtQuick

CSliderBase {
    id: root

    implicitWidth: horizontal ? 200 : 12
    implicitHeight: horizontal ? 12 : 200

    contentItem: Rectangle {
        anchors.fill: parent
        color: root.bgColor
        radius: 100

        Rectangle {
            id: filled
            color: root.fgColor
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            implicitHeight: root.height
            implicitWidth: root.width * root.pos
            radius: 100
        }
    }
}
