pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Shapes

import qs.config

Item {
    id: root
    property color color: Colors.text

    property real brightness: 1

    implicitWidth: 200
    implicitHeight: 200

    property int strokeWidth: 8

    Shape {
        id: shape
        preferredRendererType: Shape.CurveRenderer
        fillMode: Shape.PreserveAspectFit
        anchors.fill: parent
        ShapePath {
            startX: 60
            startY: 40

            fillColor: root.color
            strokeColor: root.color
            strokeWidth: root.strokeWidth

            // qmlformat off
            PathArc { relativeX: 0; relativeY: 40; radiusY: 20; radiusX: 20 }
            PathArc { relativeX: 0; relativeY: -40; radiusY: 20; radiusX: 20 }
            // qmlformat on
        }
        // qmlformat off
        LightRay { angle: 0 }
        LightRay { angle: 45 }
        LightRay { angle: 90 }
        LightRay { angle: 135 }
        LightRay { angle: 180 }
        LightRay { angle: 225 }
        LightRay { angle: 270 }
        LightRay { angle: 315 }
        // qmlformat on
    }

    component LightRay: ShapePath {
        id: ray
        property int angle
        property real radius: root.brightness * 20
        property real offset: 40
        strokeWidth: root.strokeWidth
        strokeColor: root.color
        fillColor: "transparent"
        property real angleRAD: ray.angle / 180 * Math.PI
        capStyle: ShapePath.RoundCap
        joinStyle: ShapePath.RoundJoin

        startX: offset * Math.cos(ray.angleRAD) + 60
        startY: offset * Math.sin(ray.angleRAD) + 60

        PathLine {
            relativeX: ray.radius * Math.cos(ray.angleRAD)
            relativeY: ray.radius * Math.sin(ray.angleRAD)
        }
    }
}
