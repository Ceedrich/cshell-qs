import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts

import qs.widgets
import qs.config
import qs.services

WrapperRectangle {
    id: root
    enum Type {
        None,
        Range
    }

    property int type: Osd.None

    color: Colors.surface0
    margin: Config.spacing
    radius: Config.border.radius

    visible: type !== Osd.None

    Loader {
        id: loader

        sourceComponent: {
            switch (root.type) {
            case Osd.Range:
                return root.rangeComponent;
            default:
                return root.nullComponent;
            }
        }
    }

    readonly property Component nullComponent: Component {
        Item {}
    }

    readonly property Component rangeComponent: Component {
        RowLayout {
            CText {
                text: OsdService.label
            }

            Rectangle {
                implicitWidth: 300
                Layout.fillHeight: true

                color: Colors.surface2
                radius: Config.border.radius

                Rectangle {
                    color: Colors.text
                    height: parent.height
                    implicitWidth: OsdService.value * parent.implicitWidth
                    anchors.left: parent.left
                    radius: Config.border.radius
                }
            }

            CText {
                text: OsdService.secondaryLabel
            }
        }
    }
}
