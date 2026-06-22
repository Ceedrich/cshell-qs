pragma Singleton

import Quickshell
import QtQuick

import qs.utils

Singleton {
    id: root
    readonly property string formattedTime: Utils.formatTime(clock.date)
    readonly property string formattedDate: Utils.formatDate(clock.date)

    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }

    readonly property int minutes: clock.date.getMinutes()
    readonly property int hours: clock.date.getHours()

    readonly property real hoursReal: hours + clock.date.getMinutes() / 60
}
