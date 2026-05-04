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
            required property var modelData
            screen: modelData
            color: Style.base

            anchors {
                top: true
                left: true
                right: true
            }

            implicitHeight: 30

            RowLayout {
                anchors.centerIn: parent

                spacing: 8

                Text {
                    text: Time.time
                    color: Style.overlay0
                }

                Workspaces {}

                Volume {}

                Battery {}

                Brightness {}

                Tray {}
            }
        }
    }
}
