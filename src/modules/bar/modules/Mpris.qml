import QtQuick
import QtQuick.Layouts

import Quickshell

import qs.widgets
import qs.services
import qs.config

BarPill {
    visible: MprisService.available
    enabled: visible
    RowLayout {
        id: rootItem
        CText {
            id: textRoot

            Layout.preferredWidth: Config.maxMprisWidth
            readonly property string icon: MprisService.playerIcon

            text: textRoot.formatText()
            color: Colors.overlay1

            function formatText(): string {
                return `${icon} ${MprisService.title} - ${MprisService.artist}`;
            }

            HoverHandler {
                cursorShape: hovered && Qt.CursorShape.PointingHandCursor
            }

            TapHandler {
                acceptedButtons: Qt.LeftButton | Qt.RightButton

                onTapped: (eventPoint, button) => _onClicked(button)

                function _onClicked(button): void {
                    if (button === Qt.RightButton) {
                        MprisService.togglePlaying();
                        return;
                    }
                    if (button === Qt.LeftButton) {
                        playerPopup.visible = !playerPopup.visible;
                        return;
                    }
                }
            }

            WheelHandler {
                property bool handled: false
                acceptedDevices: PointerDevice.Mouse | PointerDevice.TouchPad
                orientation: Qt.Horizontal

                onActiveChanged: () => {
                    if (!active) {
                        handled = false;
                    }
                }
                onWheel: evt => _onWheel(evt)

                function _onWheel(evt: WheelEvent): void {
                    if (handled) {
                        return;
                    }
                    const delta = evt.angleDelta.x;
                    if (delta < 0) {
                        MprisService.previous();
                    }

                    if (delta > 0) {
                        MprisService.next();
                    }

                    handled = true;
                }
            }
        }

        BarPopup {
            id: playerPopup
            barItem: rootItem

            anchor.rect.x: 0

            MprisPopup {
                popup: playerPopup
            }
        }
    }
}
