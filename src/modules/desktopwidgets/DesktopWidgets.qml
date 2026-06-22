import Quickshell
import QtQuick

import qs.modules.desktopwidgets.widgets
import qs.config

PanelWindow {
    anchors {
        left: true
        right: true
        bottom: true
        top: true
    }

    margins {
        top: Config.margin
        bottom: Config.margin
        left: Config.margin
        right: Config.margin
    }

    aboveWindows: false

    color: "transparent"

    ClockWidget {
        identifier: "widget-clock"
    }
    CalendarWidget {
        identifier: "widget-calendar"
    }
}
