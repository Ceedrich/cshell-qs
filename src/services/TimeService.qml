pragma Singleton

import Quickshell
import QtQuick

import qs.utils

Singleton {
    id: root
    readonly property string time: `${Utils.formatDate(clock.date)} | ${Utils.formatTime(clock.date)}`

    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }
}
