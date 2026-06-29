pragma Singleton

import Quickshell
import Quickshell.Services.Pipewire
import QtQuick

import qs.utils

Singleton {
    id: root

    property real volume: sink?.audio?.volume ?? 0
    property bool muted: sink?.audio?.muted ?? false

    readonly property bool ready: Pipewire.ready && sink != null
    readonly property PwNode sink: Pipewire.defaultAudioSink

    property list<PwNode> sources
    property list<PwNode> sinks
    property list<PwNode> streams

    PwObjectTracker {
        id: obj
        objects: [...root.sinks, ...root.streams, ...root.sources, root.sink]
    }

    Connections {
        target: Pipewire.nodes

        function onValuesChanged() {
            const mySinks = [];
            const mySources = [];
            const myStreams = [];
            for (const node of Pipewire.nodes.values) {
                if (!node.isStream && node.isSink && node.audio != null) {
                    mySinks.push(node);
                    continue;
                }
                if (!node.isStream && !node.isSink && node.audio != null) {
                    mySources.push(node);
                    continue;
                }
                if (node.isStream && node.audio != null) {
                    myStreams.push(node);
                    continue;
                }
            }
            root.sinks = mySinks;
            root.sources = mySources;
            root.streams = myStreams;
        }
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
        if (ready && sink.audio) {
            sink.audio.muted = muted;
        }
    }
}
