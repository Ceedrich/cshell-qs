import Quickshell
import QtQuick
import QtQuick.Layouts

import qs.config
import qs.widgets

Scope {
    id: root
    property string time

    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: window
            margins {
                top: Config.spacing
                right: Config.spacing * 2
                left: Config.spacing * 2
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

            Center {
                anchors.centerIn: parent
            }

            Right {
                anchors.right: parent.right
            }
        }
    }
}
