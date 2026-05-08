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

            PopupWindow {
                id: controlCenterWindow
                anchor.window: window
                anchor.rect.x: parentWindow.width - width
                anchor.rect.y: parentWindow.height + Config.spacing

                implicitWidth: child.implicitWidth
                implicitHeight: child.implicitHeight

                color: "transparent"

                ControlCenter {
                    id: child
                }
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
