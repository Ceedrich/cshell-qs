pragma Singleton
import Quickshell
import QtQuick

Singleton {
    readonly property int margin: 8
    readonly property int spacing: 12

    readonly property string fontFamily: "Jetbrains Mono Nerd Font"
    readonly property int fontSize: 14

    readonly property var border: ({
            width: 1,
            radius: spacing
        })
}
