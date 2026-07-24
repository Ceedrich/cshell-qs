pragma Singleton
import Quickshell
import QtQuick

Singleton {
    readonly property int margin: 8
    readonly property int spacing: 12

    property FontConfig font: FontConfig {}

    readonly property int maxMprisWidth: 400
    readonly property int mprisPopupWidth: 400

    readonly property int longHoverTime: 500

    readonly property var border: ({
            width: 2,
            radius: barHeight / 2
        })

    readonly property int barHeight: 45

    readonly property int notificationDismissTimeout: 5000

    component NumberAnimationSimple: NumberAnimation {
        duration: 300
        easing: Easing.OutCubic
    }

    component NumberAnimationQuick: NumberAnimation {
        duration: 40
        easing: Easing.Linear
    }
    component ColorAnimationQuick: ColorAnimation {
        duration: 40
        easing: Easing.Linear
    }
    component CColorAnimation: ColorAnimation {
        duration: 100
    }

    component FontConfig: QtObject {
        readonly property int textPixelSize: 14
        readonly property int headingPixelSize: 16
        readonly property int titlePixelSize: 18

        readonly property string familyMono: "Jetbrains Mono Nerd Font"
    }
}
