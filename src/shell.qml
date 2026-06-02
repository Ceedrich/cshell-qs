//@ pragma UseQApplication
//@ pragma IconTheme Papirus-Dark

import Quickshell
import QtQuick

import qs.modules.bar
import qs.modules.overview
import qs.modules

ShellRoot {
    id: root

    BarExclusionZone {}

    BackgroundWindow {}

    MainWindow {}

    OverviewWindow {}
}
