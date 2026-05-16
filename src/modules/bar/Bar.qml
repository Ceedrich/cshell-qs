import Quickshell
import Quickshell.Wayland
import QtQuick

import qs.config
import qs.modules.bar.modules

Scope {
    id: root
    property string time

    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: window

            WlrLayershell.layer: WlrLayer.Top
            WlrLayershell.namespace: "cshell-bar"

            margins {
                top: Config.margin
                right: Config.margin
                left: Config.margin
            }
            required property var modelData
            screen: modelData

            color: "transparent"

            anchors {
                top: true
                left: true
                right: true
            }

            implicitHeight: 45

            Mpris {
                anchors.left: parent.left
            }

            WidgetsCenter {
                barWindow: window
                anchors.centerIn: parent
            }

            WidgetsRight {
                barWindow: window
                anchors.right: parent.right
            }
        }
    }
}
