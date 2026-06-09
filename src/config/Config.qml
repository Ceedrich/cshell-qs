pragma Singleton
import Quickshell
import QtQuick

Singleton {
    readonly property int margin: 8
    readonly property int spacing: 12
    readonly property real scrollFactor: 0.05

    readonly property string fontFamily: "Jetbrains Mono Nerd Font"
    readonly property int fontSize: 14

    readonly property int maxMprisWidth: 400
    readonly property int mprisPopupWidth: 400

    readonly property int longHoverTime: 500

    readonly property var border: ({
            width: 2,
            radius: barHeight / 2
        })

    readonly property int barHeight: 45

    component NumberAnimationSimple: NumberAnimation {
        duration: 300
        easing: Easing.InOutCubic
    }

    component NumberAnimationQuick: NumberAnimation {
        duration: 40
        easing: Easing.Linear
    }
    component ColorAnimationQuick: ColorAnimation {
        duration: 40
        easing: Easing.Linear
    }
}
