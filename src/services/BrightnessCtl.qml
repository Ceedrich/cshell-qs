pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root
    property int percentage: 100

    Process {
        id: query_proc
        command: ["brightnessctl", "-m", "i"]
        running: true
        stdout: SplitParser {
            onRead: data => root.percentage = root.parseOutput(data)
        }
    }

    Timer {
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
