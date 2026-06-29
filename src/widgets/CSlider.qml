import QtQuick
import QtQuick.Templates

import qs.config
import qs.utils
import qs.services

Slider {
    id: root
    value: 0.5

    property real pos: visualPosition
    property bool interactionOnMove: true

    signal interaction(value: real)

    implicitWidth: 200
    implicitHeight: 8

    contentItem: Rectangle {
        anchors.fill: parent
        color: Colors.surface2
        radius: 100

        Rectangle {
            id: filled
            color: Colors.overlay2
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            implicitHeight: root.height
            implicitWidth: root.width * root.pos
            radius: 100
        }
    }

    Binding {
        id: posBinding
        target: root
        property: "pos"
        value: Utils.clamp(0, 1, mouse.pos)
        when: mouse.pressed
    }

    Binding {
        id: wheelPosBinding
        target: root
        property: "pos"
        value: Utils.clamp(0, 1, mouse.wheelStartX + mouse.wheelDelta)
        when: mouse.wheelActive
    }

    MouseArea {
        id: mouse
        property real pos
        property bool wheelActive: false
        property real wheelDelta
        property real wheelStartX

        anchors.left: parent.left
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        implicitHeight: root.height

        onPressed: e => pos = e.x / width
        onPositionChanged: e => {
            pos = e.x / width;
            if (root.interactionOnMove) {
                interaction();
            }
        }
        onReleased: interaction()

        onWheel: e => {
            if (!wheelActive) {
                wheelStartX = root.visualPosition;
                wheelDelta = 0;
            }
            wheelTimeout.restart();
            wheelActive = true;

            const delta = (e.angleDelta.y * SettingsService.data.scrollFactor) / 20 / width;
            wheelDelta += delta;

            if (root.interactionOnMove) {
                interaction();
                wheelDelta = 0;
            }
        }

        function interaction() {
            root.interaction(root.from + root.pos * (root.to - root.from));
        }
    }

    Timer {
        id: wheelTimeout
        interval: 150
        onTriggered: {
            mouse.interaction();
            mouse.wheelActive = false;
        }
    }
}
