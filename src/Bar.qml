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

            PopupWindow {
                id: controlCenterWindow
                anchor.window: parentWindow
                width: 500
                height: 500
                visible: true
            }

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

            Center {
                anchors.centerIn: parent
            }

            RowLayout {
                anchors.right: parent.right
                BarPill {
                    RowLayout {
                        Tray {}
                    }
                }

                BarPill {
                    RowLayout {
                        ControlCenterToggle {
                            controlPanelWindow: controlCenterWindow
                        }
                    }
                }
            }
        }
    }
}
