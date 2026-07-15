//@ pragma UseQApplication
//@ pragma IconTheme Papirus-Dark

import Quickshell
import QtQuick

import qs.modules.bar
import qs.modules.overview
import qs.modules.desktopwidgets
import qs.modules.notifications
import qs.modules.controlcenter
import qs.modules

ShellRoot {
    id: root

    Variants {
        model: Quickshell.screens

        delegate: Scope {
            id: scope
            required property ShellScreen modelData
            property ShellScreen screen: modelData

            BarExclusionZone {
                screen: scope.screen
            }

            BackgroundWindow {
                screen: scope.screen
            }

            DesktopWidgets {
                screen: scope.screen
            }

            MainWindow {
                screen: scope.screen
            }

            OverviewWindow {
                screen: scope.screen
            }

            ControlCenterWindow {
                screen: scope.screen
            }

            NotificationWindow {
                screen: scope.screen
            }
        }
    }
}
