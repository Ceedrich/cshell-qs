import QtQuick

CTextNoHandlers {
    id: root
    property var onEntered
    property var onClicked
    property var onExited
    property var onWheel

    MouseArea {
        anchors.fill: parent

        hoverEnabled: (root.onEntered || root.onExited || false)

        onClicked: evt => {
            if (root.onClicked) {
                root.onClicked(evt);
            }
        }

        cursorShape: (root.onClicked && Qt.PointingHandCursor)

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
