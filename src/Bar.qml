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
                right: Config.spacing
                left: Config.spacing
            }
            required property var modelData
            screen: modelData
            color: Colors.base

            anchors {
                top: true
                left: true
                right: true
            }

            implicitHeight: 30

            RowLayout {
                anchors.leftMargin: Config.spacing
                anchors.rightMargin: Config.spacing
                anchors.fill: parent
                spacing: Config.spacing

                Item {
                    Layout.fillWidth: true
                }

                // center items
                Clock {}
                Workspaces {}
                Volume {}
                Battery {}
                Brightness {}

                Item {
                    Layout.fillWidth: true
                }

                // right items
                Tray {}
            }
        }
    }
}
