import QtQuick

import qs.config

Item {
    id: root
    property alias highlight: highlight.enabled
    property alias highlightOnHover: mousearea.enabled

    signal dropped(drop: DragEvent)

    Rectangle {
        id: highlight
        anchors.fill: parent

        color: Colors.overlay2

        opacity: (droparea.containsDrag || mousearea.containsMouse) ? 0.3 : 0.0

        Behavior on opacity {
            NumberAnimation {
                duration: Config.animationDuration.quick
                easing.type: Config.animationEasingTypes.quick
            }
        }
    }

    DropArea {
        id: droparea
        anchors.fill: root
        onDropped: evt => root.dropped(evt)
    }

    MouseArea {
        id: mousearea
        anchors.fill: root
        acceptedButtons: Qt.NoButton
        hoverEnabled: true
    }
}
