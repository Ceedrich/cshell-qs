pragma Singleton

import Quickshell
import Quickshell.Services.Pipewire
import QtQuick

import qs.utils

Singleton {
    id: root

    property real volume: sink?.audio?.volume ?? 0
    property bool muted: sink?.audio?.muted ?? false

    readonly property string volumeIcon: {
        if (sink?.properties["api.bluez5.address"]) {
            return "󰂰";
        }
        const icons = ["󰕿", "󰖀", "󰕾"];
        const icon_muted = "󰝟";

        if (!VolumeService.ready) {
            return "";
        }

        if (VolumeService.muted) {
            return icon_muted;
        }
        const icon = Utils.select_from_list(VolumeService.volume, icons);
        return icon;
    }

    readonly property bool ready: Pipewire.ready && sink != null && sink.audio != null
    readonly property PwNode sink: Pipewire.defaultAudioSink

    property list<PwNode> sinks: Pipewire.nodes.values.filter(n => !n.isStream && n.isSink && n.audio != null)
    property list<PwNode> sources: Pipewire.nodes.values.filter(n => !n.isStream && !n.isSink && n.audio != null)
    property list<PwNode> streams: Pipewire.nodes.values.filter(n => n.isStream && n.audio != null && n.type === 21) // Stream/Output/Audio (see https://docs.pipewire.org/page_man_pipewire-props_7.html#node-prop__media_class)

    Timer {
        running: root.ready
        interval: 10
        onTriggered: osdWatcher.enabled = true
    }

    Connections {
        id: osdWatcher
        enabled: false
        function onVolumeChanged() {
            OsdService.setRange(root.volume, "Volume", Utils.leftPad(`${Math.round(root.volume * 100)}%`, 4));
        }
    }

    PwObjectTracker {
        id: obj
        objects: [...root.sinks, ...root.streams, ...root.sources, root.sink]
    }

    function setNodeVolume(node: PwNode, volume: real) {
        if (node?.ready && node?.audio) {
            node.audio.volume = Utils.clamp(0, 1, volume);
        }
    }

    function setVolume(volume: real) {
        setNodeVolume(sink, volume);
    }
    function incrementVolume(delta: real) {
        setVolume(volume + delta);
    }
    function decrementVolume(delta: real) {
        setVolume(volume - delta);
    }

    function toggleMuted() {
        setMuted(!muted);
    }

    function setMuted(muted: bool) {
        if (ready && sink.audio && sink.audio.muted !== muted) {
            sink.audio.muted = muted;
        }
    }
}
