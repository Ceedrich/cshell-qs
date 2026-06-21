import QtQuick
import Quickshell.Widgets
import Quickshell

WrapperRectangle {
    id: root

    color: "transparent"

    PersistentProperties {
        id: persistent
        reloadableId: `reloadable-${root.objectName}`
        property real x
        property real y
    }

    x: persistent.x
    y: persistent.y

    DragHandler {
        id: handler
        onActiveChanged: {
            persistent.x = root.x;
            persistent.y = root.y;
        }
    }
}
