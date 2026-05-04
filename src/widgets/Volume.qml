import QtQuick
import Quickshell.Services.Pipewire

import qs.config

Text {
    id: root
    property list<string> icons: ["󰕿", "󰖀", "󰕾"]
    property string icon_muted: "󰝟"
    property double scroll_factor: 0.05

    property PwNode sink: Pipewire.defaultAudioSink
    property PwObjectTracker tracker: PwObjectTracker {
        objects: [Pipewire.defaultAudioSink]
    }
    enabled: sink?.audio != null

    property string icon: {
        if (sink?.audio == null) {
            return "";
        }
        const muted = sink?.audio?.muted || false;

        if (muted) {
            return icon_muted;
        }
        const icon_idx = Math.floor(sink.audio.volume * icons.length);
        icon = icons[Math.floor(sink.audio.volume * icons.length)];
        return icon || "";
    }
    color: sink?.audio?.muted ? Colors.overlay0 : Colors.text

    text: `${Math.round((sink?.audio?.volume || 0) * 100)}% ${icon}`

    MouseArea {
        anchors.fill: parent
        onClicked: root.sink.audio.muted = !root.sink.audio.muted
        onWheel: wheel => {
            const delta = -wheel.angleDelta.y / 100 * root.scroll_factor;
            const clamp = (low, high, value) => Math.min(Math.max(value, low), high);
            root.sink.audio.volume = clamp(0.0, 1.0, root.sink.audio.volume + delta);
        }
    }
}
