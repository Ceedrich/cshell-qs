import QtQuick
import Quickshell
import Quickshell.Wayland

Loader {
    sourceComponent: PanelWindow {
        anchors {
            top: true
            right: true
            bottom: true
            left: true
        }

        color: "transparent"

        WlrLayershell.layer: WlrLayer.Background
        WlrLayershell.exclusionMode: ExclusionMode.Ignore
        WlrLayershell.namespace: "cshell-background"

        Loader {
            sourceComponent: Image {
                source: "../assets/wallpaper.png"
            }
        }
    }
}
