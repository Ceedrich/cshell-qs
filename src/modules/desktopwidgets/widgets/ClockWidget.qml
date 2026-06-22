pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Shapes

import qs.config
import qs.widgets
import qs.services

DesktopWidget {
    objectName: "widget-clock"

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

        CText {
            text: TimeService.formattedTime
            anchors.bottom: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.margins: 0.1 * root.size
        }

        Shape {
            implicitWidth: root.size
            implicitHeight: root.size
            antialiasing: true

            ShapePath {
                id: hourHandle
                capStyle: ShapePath.RoundCap
                strokeWidth: 2
                strokeColor: Colors.text
                cosmeticStroke: true

                PathMove {
                    x: root.size / 2
                    y: root.size / 2
                }
                PathLine {
                    relativeX: root.hourVector.x
                    relativeY: root.hourVector.y
                }

                PathMove {
                    x: root.size / 2
                    y: root.size / 2
                }
                PathLine {
                    relativeX: root.minuteVector.x
                    relativeY: root.minuteVector.y
                }
            }
            // ShapePath {
            //     id: tickPath
            //     fillColor: "transparent"
            //
            //     capStyle: ShapePath.RoundCap
            //     strokeWidth: 2
            //     strokeColor: Colors.text
            //     cosmeticStroke: true
            //
            //     property real innerRadius: root.size / 2 * 0.8
            //     property real outerRadius: root.size / 2 - strokeWidth
            //
            //     // qmlformat off
            //     PathMove { x: root.size / 2; y: tickPath.outerRadius - tickPath.innerRadius }
            //     PathLine { x: root.size / 2; y: tickPath.outerRadius - tickPath.outerRadius }
            //
            //     PathMove { x: root.size / 2; y: tickPath.outerRadius + tickPath.innerRadius }
            //     PathLine { x: root.size / 2; y: tickPath.outerRadius + tickPath.outerRadius }
            //
            //     PathMove { y: root.size / 2; x: tickPath.outerRadius - tickPath.innerRadius }
            //     PathLine { y: root.size / 2; x: tickPath.outerRadius - tickPath.outerRadius }
            //
            //     PathMove { y: root.size / 2; x: tickPath.outerRadius + tickPath.innerRadius }
            //     PathLine { y: root.size / 2; x: tickPath.outerRadius + tickPath.outerRadius }
            //     // qmlformat on
            // }
        }

        property vector2d hourVector: {
            const hour = TimeService.hoursReal;
            const angle = (2 * Math.PI) * (hour % 12) / 12 - (Math.PI / 4);
            return Qt.point(hourLength * Math.cos(angle), hourLength * Math.sin(angle));
        }

        property vector2d minuteVector: {
            const minute = TimeService.minutes;
            const angle = (2 * Math.PI) * minute / 60 - (Math.PI / 2);
            return Qt.point(minuteLength * Math.cos(angle), minuteLength * Math.sin(angle));
        }
    }

    component CPathMove: PathMove {
        id: cPathMove
    }
    component CPathLine: PathLine {
        id: cPathLine
    }
}
