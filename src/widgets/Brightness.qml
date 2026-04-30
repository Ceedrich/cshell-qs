import Quickshell.Io
import QtQuick

Item {
    Text {
        id: brightness
        property int perc: 40
        text: perc + "%"
    }

    Process {
        id: proc
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
                brightness.perc = +(perc.replace('%', ''));
            }
        }
    }
    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: proc.running = true
    }
}
