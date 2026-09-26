import QtQuick
import QtQuick.Templates

import qs.config
import qs.utils
import qs.services

Slider {
    id: root
    value: 0.5

    property bool interactionOnMove: true
    readonly property real pos: _pos

    signal interaction(value: real)

    property real _pos: horizontal ? visualPosition : 1 - visualPosition

    readonly property color fgColor: enabled ? Colors.text : Colors.overlay1
    readonly property color bgColor: enabled ? Colors.surface2 : Colors.surface1

    Binding {
        id: posBinding
        target: root
        property: "_pos"
        value: Utils.clamp(0, 1, mouse.pos)
        when: mouse.pressed
    }

    Binding {
        id: wheelPosBinding
        target: root
        property: "_pos"
        value: Utils.clamp(0, 1, mouse.wheelStartX + mouse.wheelDelta)
        when: mouse.wheelActive
    }

    MouseArea {
        id: mouse
        property real pos
        property bool wheelActive: false
        property real wheelDelta
        property real wheelStartX

        scrollGestureEnabled: true
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        implicitHeight: root.height

        onPressed: e => pos = root.horizontal ? e.x / width : 1 - e.y / height
        onPositionChanged: e => {
            pos = root.horizontal ? e.x / width : 1 - e.y / height;
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

            const delta = (e.angleDelta.y * SettingsService.data.scrollFactor) / 20 / (root.horizontal ? width : height);
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
