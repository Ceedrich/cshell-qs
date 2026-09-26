pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Wayland
import QtQuick

import qs.modules.desktopwidgets.widgets
import qs.widgets.ContextMenu

PanelWindow {
    anchors {
        left: true
        right: true
        bottom: true
        top: true
    }

    WlrLayershell.namespace: "cshell-desktop-widgets"
    WlrLayershell.exclusionMode: ExclusionMode.Ignore
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
            CContextMenuItem {
                label: "Destkop Widgets"
                type: CContextMenuItem.Label
            },
            ItemToggler {
                target: widgetClock
            },
            ItemToggler {
                target: widgetCalendar
            },
            ItemToggler {
                target: widgetTimerStopwatch
            }
        ]
    }

    ClockWidget {
        id: widgetClock
        identifier: "widget-clock"
        name: "Clock"
    }
    CalendarWidget {
        id: widgetCalendar
        identifier: "widget-calendar"
        name: "Calendar"
    }
    TimerStopwatchWidget {
        id: widgetTimerStopwatch
        identifier: "widget-timer-stopwatch"
        name: "Timer/Stopwatch"
    }

    component ItemToggler: CContextMenuItem {
        property var target
        type: CContextMenuItem.Checkbox
        label: `Show ${target.name} Widget`
        isChecked: target.enabled
        onTriggered: target.toggleEnabled()
    }
}
