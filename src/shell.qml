//@ pragma UseQApplication
//@ pragma IconTheme Papirus-Dark

import Quickshell
import QtQuick

import qs.modules
import qs.modules.bar
import qs.modules.controlcenter
import qs.modules.desktopwidgets
import qs.modules.notifications
import qs.modules.osd
import qs.modules.overview

ShellRoot {
    id: root

    Variants {
        model: Quickshell.screens

        Scope {
            id: scope
            required property ShellScreen modelData

            BarExclusionZone {
                screen: scope.modelData
            }

            BackgroundWindow {
                screen: scope.modelData
            }

            DesktopWidgets {
                screen: scope.modelData
            }

            MainWindow {
                screen: scope.modelData
            }

            OverviewWindow {
                screen: scope.modelData
            }

            ControlCenterWindow {
                screen: scope.modelData
            }

            NotificationWindow {
                screen: scope.modelData
            }

            OsdWindow {
                screen: scope.modelData
            }
        }
    }
}
