import QtQuick
import Quickshell.Wayland

Item {
    id: root

    property alias live: screen.live
    property real windowScale: 0.5
    required property Toplevel window

    visible: screen.hasContent
    implicitWidth: screen.sourceSize.width * windowScale || 200
    implicitHeight: screen.sourceSize.height * windowScale || 200

    function captureFrame() {
        screen.captureFrame();
    }

    ScreencopyView {
        id: screen
        anchors.fill: parent
        captureSource: root.window
    }
}
