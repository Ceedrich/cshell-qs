pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls as Ctl

import Quickshell.Widgets

import qs.config

WrapperRectangle {
    id: root

    enum ContainerState {
        None,
        Override,
        Hovered
    }

    required property Item defaultItem
    property Item hoverItem
    property Item overrideItem

    property bool override: false
    property bool hoverAnimationEnabled: true

    readonly property alias hovered: hover.hovered
    readonly property alias stack: stack

    readonly property int transitionDuration: 200
    readonly property int containerState: override ? Container.Override : hovered ? Container.Hovered : Container.None

    Timer {
        id: cleanupTimer
        interval: 5000
        repeat: true
        onTriggered: {
            if (stack.depth === 0) {
                stop();
            } else {
                stack.pop();
            }
        }
    }

    margin: Config.spacing

    color: Colors.base
    radius: Config.border.radius
    border.width: Config.border.width
    border.color: Colors.overlay2

    states: [
        State {
            name: ""
            when: root.containerState === Container.None && root.defaultItem

            StateChangeScript {
                script: if (root.defaultItem) {
                    stack.replace(root.defaultItem);
                }
            }
        },
        State {
            name: "hovered"
            when: root.containerState === Container.Hovered && root.hoverItem

            StateChangeScript {
                script: if (root.hoverItem) {
                    stack.replace(root.hoverItem);
                }
            }
        },
        State {
            name: "override"
            when: root.containerState === Container.Override && root.overrideItem

            StateChangeScript {
                script: if (root.overrideItem) {
                    stack.replace(root.overrideItem);
                }
            }
        }
    ]

    HoverHandler {
        id: hover
    }

    ClippingRectangle {
        color: "transparent"

        implicitWidth: stack.implicitWidth
        implicitHeight: stack.implicitHeight

        Ctl.StackView {
            id: stack

            initialItem: root.defaultItem || null

            implicitWidth: currentItem.implicitWidth
            implicitHeight: currentItem.implicitHeight

            Behavior on implicitWidth {
                Anim {}
            }

            Behavior on implicitHeight {
                Anim {}
            }

            replaceEnter: Transition {
                Anim {
                    from: 0
                    property: "opacity"
                    to: 1
                }
            }
            replaceExit: Transition {
                Anim {
                    from: 1
                    property: "opacity"
                    to: 0
                }
            }
        }
    }

    component Anim: SpringAnimation {
        duration: root.transitionDuration
        spring: 5
        damping: 0.5
    }
}
