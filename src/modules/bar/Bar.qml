import Quickshell
import QtQuick
import QtQuick.Layouts

import qs.config
import qs.modules.bar.modules

Scope {
    id: root
    property string time

    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: window

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

            Mpris {}

            Center {
                barWindow: window
                anchors.centerIn: parent
            }

            RowLayout {
                anchors.right: parent.right
                BarPill {
                    RowLayout {
                        spacing: Config.spacing
                        IdleInhibitor {}
                        Tray {
                            barWindow: window
                        }
                    }
                }

                BarPill {
                    RowLayout {
                        ControlCenterToggle {
                            barWindow: window
                        }
                    }
                }
            }
        }
    }
}
