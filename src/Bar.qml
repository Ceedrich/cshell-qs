import Quickshell
import QtQuick
import QtQuick.Layouts

import qs.config

import "./widgets"

Scope {
    id: root
    property string time

    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: window
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
                anchors.leftMargin: 8
                anchors.rightMargin: 8
                anchors.fill: parent
                spacing: 8

                // left items

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
