pragma Singleton

import Quickshell
import Quickshell.Services.Pipewire

Singleton {
    property real volume
    property bool muted

    property PwNode xx: Pipewire.defaultAudioSink
}
