import QtQuick
import Quickshell.Services.Pipewire

import qs.config
import qs.utils
import qs.widgets

CBarItem {
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
    textColor: muted ? Colors.overlay1 : defaultColor
    underline: !muted

    text: `${Math.round((sink?.audio?.volume || 0) * 100)}% ${icon}`

    onClicked: root.sink.audio.muted = !root.sink.audio.muted
    onScrollY: delta => root.sink.audio.volume = Utils.clamp(0.0, 1.0, root.sink.audio.volume + delta / 100)
}
