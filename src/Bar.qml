import Quickshell
import QtQuick
import QtQuick.Layouts
import "./widgets"

Scope {
    id: root
    property string time

    Variants {
        model: Quickshell.screens

        PanelWindow {
            required property var modelData
            screen: modelData

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
