import Quickshell
import Quickshell.Io
import QtQuick

Scope {
    id: root
    property int percentage: 100

    Process {
        id: set_proc
        command: ["brightnessctl", "-m", "s", `${root.percentage}%`]
    }

    Process {
        id: query_proc
        command: ["brightnessctl", "-m", "i"]
        stdout: SplitParser {
            onRead: data => {
                if (!data) {
                    return;
                }
                var perc = data.split(",")[3];
                if (!perc) {
                    return;
                }
                root.percentage = +(perc.replace('%', ''));
            }
        }
    }
    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: query_proc.running = true
    }
}
