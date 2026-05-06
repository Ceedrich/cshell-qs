import QtQuick

import qs.config

Text {
    id: root
    property bool underline: false
    property var onEntered
    property var onClicked
    property var onExited
    property var onWheel

    font.family: Config.fontFamily
    font.pixelSize: Config.fontSize

    color: Colors.text

    bottomPadding: Config.spacing / 2
    topPadding: Config.spacing / 2

    Rectangle {
        visible: root.underline
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        height: 1
        color: root.color
    }

    MouseArea {
        anchors.fill: parent

        hoverEnabled: (root.onEntered || root.onExited || false)

        onClicked: evt => {
            if (root.onClicked) {
                root.onClicked(evt);
            }
        }

        onEntered: () => {
            if (root.onEntered) {
                root.onEntered();
            }
        }

        onExited: () => {
            if (root.onExited) {
                root.onExited();
            }
        }

        onWheel: evt => {
            if (root.onWheel) {
                root.onWheel(evt);
            }
        }
    }
}
