pragma Singleton
import Quickshell
import QtQuick

Singleton {
    readonly property int margin: 8
    readonly property int spacing: 12
    readonly property font defaultFont: ({
            family: "Jetbrains Mono Nerd Font",
            pixelSize: 14
        })
}
