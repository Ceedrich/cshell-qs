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

    readonly property var border: ({
            width: 1,
            radius: spacing
        })
}
