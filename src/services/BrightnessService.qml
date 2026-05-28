pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

// updatePercentage => set_proc

Singleton {
    id: root
    property int percentage: _perc

    property bool available

    property int _perc: 100

    onPercentageChanged: () => {
        if (percentage === _perc) {
            return;
        }
        timer.restart();
        query_proc.running = false;
        set_proc.running = true;
    }

    Process {
        id: visibleProces
        command: ["brightnessctl", "--class=backlight", "-m", "i"]
        running: true
        onExited: exitCode => {
            if (exitCode === 0) {
                root.available = true;
            }
        }
    }

    Process {
        id: set_proc
        command: ["brightnessctl", "-m", "s", `${root.percentage}%`]
    }

    Process {
        id: query_proc
        command: ["brightnessctl", "-m", "i"]
        running: true
        stdout: SplitParser {
            onRead: data => {
                const perc = root.parseOutput(data);
                root._perc = perc;
                root.percentage = perc;
            }
        }
    }

    Timer {
        id: timer
        interval: 1000
        running: true
        repeat: true
        onTriggered: query_proc.running = true
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
