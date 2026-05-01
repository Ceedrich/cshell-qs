import QtQuick
import Quickshell.Services.Pipewire

Text {
    id: root
    property list<string> icons: ["󰕿", "󰖀", "󰕾"]
    property string icon_muted: "󰝟"
    property double scroll_factor: 0.05

    property PwNode sink: Pipewire.defaultAudioSink
    property PwObjectTracker tracker: PwObjectTracker {
        objects: [Pipewire.defaultAudioSink]
    }
    enabled: sink.audio != null

    property bool muted: sink.audio.muted
    property int perc: Math.round(sink.audio.volume * 100)

    property string icon: muted ? icon_muted : icons[Math.floor(sink.audio.volume * icons.length)]
    color: muted ? "gray" : "black"

    text: `${perc}% ${icon}`

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
