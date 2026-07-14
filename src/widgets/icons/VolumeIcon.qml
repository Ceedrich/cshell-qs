pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Shapes

import qs.config

IconBase {
    id: root

    required property real volume

    Shape {
        id: shape
        preferredRendererType: Shape.CurveRenderer
        anchors.fill: parent
        fillMode: Shape.PreserveAspectFit

        MyPath {
            id: speaker

            startX: 0
            startY: 20

            // qmlformat off
            PathLine { relativeX: 0; relativeY: 40 }
            PathLine { relativeX: 20; relativeY: 0 }
            PathLine { relativeX: 20; relativeY: 20 }
            PathLine { relativeX: 0; relativeY: -80 }
            PathLine { relativeX: -20; relativeY: 20 }
            PathLine { relativeX: -20; relativeY: 0 }
            // qmlformat on
        }

        MyPath {
            id: bar1
            fillColor: "transparent"
            strokeColor: root.volume > 0 ? root.strokeColor : Qt.alpha(root.strokeColor, 0.2)

            startX: 55
            startY: 30

            PathArc {
                relativeX: 0
                relativeY: 20
                radiusX: relativeY
                radiusY: relativeY
            }
        }

        MyPath {
            id: bar2
            fillColor: "transparent"
            strokeColor: root.volume >= 1.0 / 3.0 ? root.strokeColor : Qt.alpha(root.strokeColor, 0.2)

            startX: 70
            startY: 20

            PathArc {
                relativeX: 0
                relativeY: (40 - bar2.startY) * 2
                radiusX: relativeY
                radiusY: relativeY
            }
        }

        MyPath {
            id: bar3
            fillColor: "transparent"
            strokeColor: root.volume >= 2.0 / 3.0 ? root.strokeColor : Qt.alpha(root.strokeColor, 0.2)
            startX: 85
            startY: 10

            PathArc {
                relativeX: 0
                relativeY: (40 - bar3.startY) * 2
                radiusX: relativeY
                radiusY: relativeY
            }
        }
    }

    component MyPath: ShapePath {
        fillColor: root.fillColor
        strokeColor: root.strokeColor
        strokeWidth: root.strokeWidth
        joinStyle: ShapePath.RoundJoin
        capStyle: ShapePath.RoundCap

        Behavior on strokeColor {
            Config.CColorAnimation {}
        }
    }
}
