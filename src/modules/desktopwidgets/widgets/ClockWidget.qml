pragma ComponentBehavior: Bound

import Quickshell.Widgets
import QtQuick
import QtQuick.Shapes

import qs.config
import qs.widgets
import qs.services

DesktopWidget {
    Rectangle {
        id: root

        property int size: 200
        property int minuteLength: (size / 2) * 0.7
        property int hourLength: (size / 2) * 0.5

        implicitWidth: size
        implicitHeight: size

        border.color: Colors.overlay2
        border.width: 2

        radius: 100 * width

        color: Colors.base

        Shape {
            implicitWidth: root.size
            implicitHeight: root.size
            antialiasing: true

            ShapePath {
                id: handles
                capStyle: ShapePath.RoundCap
                strokeWidth: 2
                strokeColor: Colors.text
                cosmeticStroke: true

                // qmlformat off
                PathMove { x: root.size / 2; y: root.size / 2 }
                PathLine { relativeX: root.hourVector.x; relativeY: root.hourVector.y; }

                PathMove { x: root.size / 2; y: root.size / 2; }
                PathLine { relativeX: root.minuteVector.x; relativeY: root.minuteVector.y; }
                // qmlformat on
            }
        }

        Item {
            implicitWidth: timeText.implicitWidth
            implicitHeight: timeText.implicitHeight
            anchors.bottom: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.margins: 0.15 * root.size
            CText {
                id: timeText
                text: TimeService.formattedTime
            }
        }

        property vector2d hourVector: {
            const hour = TimeService.hoursReal;
            const angle = (2 * Math.PI) * hour / 12 - (Math.PI / 2);
            return Qt.point(hourLength * Math.cos(angle), hourLength * Math.sin(angle));
        }

        property vector2d minuteVector: {
            const minute = TimeService.minutes;
            const angle = (2 * Math.PI) * minute / 60 - (Math.PI / 2);
            return Qt.point(minuteLength * Math.cos(angle), minuteLength * Math.sin(angle));
        }
    }
}
