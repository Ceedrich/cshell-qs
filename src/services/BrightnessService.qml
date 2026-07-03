pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

import qs.utils

Singleton {
    id: root
    readonly property int percentage: Math.round(_percentage)

    property real _percentage

    readonly property bool available: hasBacklight && didFirstQuery

    property bool didFirstQuery: false
    property bool hasBacklight: false

    property bool interactive: false

    Process {
        id: visibleProces
        command: ["brightnessctl", "--class=backlight", "-m", "i"]
        running: true
        onExited: exitCode => {
            if (exitCode === 0) {
                root.hasBacklight = true;
            }
        }
    }

    Process {
        id: query_proc
        command: ["brightnessctl", "-m", "i"]
        running: false
        stdout: SplitParser {
            onRead: data => {
                root.didFirstQuery = true;
                const perc = root.parseOutput(data);
                root._percentage = perc;
            }
        }
    }

    Timer {
        id: queryTimer
        interval: 1000
        running: !root.interactive
        repeat: true
        onTriggered: query_proc.running = true
    }

    Timer {
        id: setTimer
        interval: 500
        running: root.interactive
        onTriggered: {
            Quickshell.execDetached(["brightnessctl", "s", `${root.percentage}%`]);
            root.interactive = false;
        }
    }

    function setBrightness(perc: real) {
        interactive = true;
        perc = Utils.clamp(0, 100, perc);
        _percentage = perc;
    }
    function increaseBrightness(delta: real) {
        setBrightness(_percentage + delta);
    }

    function decreaseBrightness(delta: real) {
        setBrightness(_percentage - delta);
    }

    function parseOutput(data: string): int {
        if (!data) {
            return;
        }
        var perc = data.split(",")[3];
        if (!perc) {
            return;
        }
        return +(perc.replace('%', ''));
    }
}
