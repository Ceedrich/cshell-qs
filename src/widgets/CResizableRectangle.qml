import QtQuick

Rectangle {
    id: root

    property real minWidth: 50
    property real minHeight: 50

    property alias resizeRight: right.enabled
    property alias resizeLeft: left.enabled
    property alias resizeTop: top.enabled
    property alias resizeBottom: bottom.enabled

    MouseArea {
        id: dragarea
        anchors.fill: parent
        drag.target: root
        cursorShape: drag.active ? Qt.ClosedHandCursor : Qt.OpenHandCursor
    }

    Item {
        id: right
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        height: parent.height - 10
        width: 5

        MouseArea {
            anchors.fill: parent
            drag {
                target: parent
                axis: Drag.XAxis
            }
            cursorShape: Qt.SizeHorCursor
            onMouseXChanged: drag.active && root._resizeRight(mouseX)
        }
    }

    Item {
        id: left
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        height: parent.height - 10
        width: 5

        MouseArea {
            anchors.fill: parent
            drag {
                target: parent
                axis: Drag.XAxis
            }
            cursorShape: Qt.SizeHorCursor
            onMouseXChanged: drag.active && root._resizeLeft(mouseX)
        }
    }

    Item {
        id: top
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        height: 5
        width: parent.width - 10

        MouseArea {
            anchors.fill: parent
            drag {
                target: parent
                axis: Drag.YAxis
            }
            cursorShape: Qt.SizeVerCursor
            onMouseYChanged: drag.active && root._resizeTop(mouseY)
        }
    }

    Item {
        id: bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        height: 5
        width: parent.width - 10

        MouseArea {
            anchors.fill: parent
            drag {
                target: parent
                axis: Drag.YAxis
            }
            cursorShape: Qt.SizeVerCursor
            onMouseYChanged: drag.active && root._resizeBottom(mouseY)
        }
    }

    Item {
        id: topleft
        enabled: top.enabled && left.enabled
        anchors.top: parent.top
        anchors.left: parent.left
        height: 5
        width: 5

        MouseArea {
            anchors.fill: parent
            drag {
                target: parent
            }
            cursorShape: Qt.SizeFDiagCursor
            onMouseXChanged: drag.active && root._resizeLeft(mouseX)
            onMouseYChanged: drag.active && root._resizeTop(mouseY)
        }
    }

    Item {
        id: topright
        enabled: top.enabled && right.enabled
        anchors.top: parent.top
        anchors.right: parent.right
        height: 5
        width: 5

        MouseArea {
            anchors.fill: parent
            drag {
                target: parent
            }
            cursorShape: Qt.SizeBDiagCursor
            onMouseXChanged: drag.active && root._resizeRight(mouseX)
            onMouseYChanged: drag.active && root._resizeTop(mouseY)
        }
    }

    Item {
        id: bottomleft
        enabled: bottom.enabled && left.enabled
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        height: 5
        width: 5

        MouseArea {
            anchors.fill: parent
            drag {
                target: parent
            }
            cursorShape: Qt.SizeBDiagCursor
            onMouseXChanged: drag.active && root._resizeLeft(mouseX)
            onMouseYChanged: drag.active && root._resizeBottom(mouseY)
        }
    }

    Item {
        id: bottomright
        enabled: bottom.enabled && right.enabled
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        height: 5
        width: 5

        MouseArea {
            anchors.fill: parent
            drag {
                target: parent
            }
            cursorShape: Qt.SizeFDiagCursor
            onMouseXChanged: drag.active && root._resizeRight(mouseX)
            onMouseYChanged: drag.active && root._resizeBottom(mouseY)
        }
    }

    function _resizeRight(delta: real) {
        root.width = Math.max(root.minWidth, root.width + delta);
    }
    function _resizeLeft(delta: real) {
        root.x += delta;
        root.width = Math.max(root.minWidth, root.width - delta);
    }
    function _resizeTop(delta: real) {
        root.y += delta;
        root.height = Math.max(root.minHeight, root.height - delta);
    }
    function _resizeBottom(delta: real) {
        root.height = Math.max(root.minHeight, root.height + delta);
    }
}
