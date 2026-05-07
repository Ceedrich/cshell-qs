import Quickshell.Io

import qs.widgets
import qs.config

CText {
    id: root
    property bool inhibiting: false

    text: inhibiting ? "󰈈" : "󰈉"

    defaultColor: Colors.blue

    color: inhibiting ? defaultColor : Colors.overlay1

    onClicked: () => inhibiting = !inhibiting

    onInhibitingChanged: () => {
        if (inhibiting) {
            inhibit_process.running = true;
        } else {
            inhibit_process.running = false;
        }
    }

    Process {
        id: inhibit_process
        command: ["systemd-inhibit", "--who=CShell", "--why='Idle Inhibit Module is turned on'", "--mode=block", "sleep", "100d",]

        onExited: () => root.inhibiting = false
    }
}
