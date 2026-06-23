pragma ComponentBehavior: Bound

import Quickshell
import QtQuick

import qs.modules.desktopwidgets.widgets
import qs.config
import qs.widgets.ContextMenu

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

    MouseArea {
        id: mouseArea
        acceptedButtons: Qt.RightButton
        anchors.fill: parent
        onClicked: {
            context.openAtPosition(mouseX, mouseY);
        }
    }

    CContextMenu {
        id: context

        model: [
            ItemToggler {
                label: "Show Clock"
                target: widgetClock
            },
            ItemToggler {
                label: "Show Calendar"
                target: widgetCalendar
            },
            ItemToggler {
                label: "Show Timer/Stopwatch"
                target: widgetTimerStopwatch
            }
        ]
    }

    ClockWidget {
        id: widgetClock
        identifier: "widget-clock"
    }
    CalendarWidget {
        id: widgetCalendar
        identifier: "widget-calendar"
    }
    TimerStopwatchWidget {
        id: widgetTimerStopwatch
        identifier: "widget-timer-stopwatch"
    }

    component ItemToggler: CContextMenuItem {
        property var target
        type: CContextMenuItem.Checkbox
        isChecked: target.enabled
        onTriggered: target.toggleEnabled()
    }
}
