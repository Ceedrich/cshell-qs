pragma Singleton
import Quickshell
import QtQuick

Singleton {
    readonly property int spacing: 8
    readonly property font defaultFont: ({
            family: "Jetbrains Mono Nerd Font",
            pixelSize: 14
        })
}
