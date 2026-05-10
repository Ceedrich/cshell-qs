import QtQuick
import Quickshell.Services.Pipewire

import qs.config
import qs.utils
import qs.widgets

CText {
    id: root
    property list<string> icons: ["󰕿", "󰖀", "󰕾"]
    property string icon_muted: "󰝟"

    readonly property bool muted: sink?.audio?.muted || false

    property PwNode sink: Pipewire.defaultAudioSink
    property PwObjectTracker tracker: PwObjectTracker {
        objects: [Pipewire.defaultAudioSink]
    }
    enabled: sink?.audio != null

    property string icon: {
        if (sink?.audio == null) {
            return "";
        }

        if (muted) {
            return icon_muted;
        }
        const icon = Utils.select_from_list(sink.audio.volume, icons);
        return icon;
    }
    color: muted ? Colors.overlay1 : defaultColor
    underline: !muted

    text: `${Math.round((sink?.audio?.volume || 0) * 100)}% ${icon}`

    onClicked: () => root.sink.audio.muted = !root.sink.audio.muted
    onWheel: wheel => {
        const delta = -wheel.angleDelta.y / 100 * Config.scrollFactor;
        const clamp = (low, high, value) => Math.min(Math.max(value, low), high);
        root.sink.audio.volume = clamp(0.0, 1.0, root.sink.audio.volume + delta);
    }
}
