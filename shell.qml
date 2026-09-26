//@ pragma UseQApplication
//@ pragma IconTheme Papirus-Dark

import Quickshell
import Quickshell.Hyprland
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

    property var focusedScreen: Quickshell.screens.find(s => s.name === Hyprland.focusedMonitor?.name) || null

    Scope {
        BackgroundWindow {
            screen: root.focusedScreen
        }

        DesktopWidgets {
            screen: root.focusedScreen
        }

        BarWindow {
            screen: root.focusedScreen
        }

        OverviewWindow {
            screen: root.focusedScreen
        }

        ControlCenterWindow {
            screen: root.focusedScreen
        }

        NotificationWindow {
            screen: root.focusedScreen
        }

        OsdWindow {
            screen: root.focusedScreen
        }
    }
}
