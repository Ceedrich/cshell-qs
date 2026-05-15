import QtQuick
import QtQuick.Layouts

import Quickshell

import qs.widgets
import qs.services
import qs.config

BarPill {
    visible: Mpris.available
    enabled: visible
    RowLayout {
        id: rootItem
        CText {
            id: textRoot

            readonly property string icon: Mpris.playerIcon

            text: textMetrics.elidedText
            color: Colors.overlay1

            TextMetrics {
                id: textMetrics
                font: textRoot.font

                elideWidth: Config.maxMprisWidth
                elide: Qt.ElideRight

                text: textRoot.formatText()
            }

            function formatText(): string {
                return `${icon} ${Mpris.title} - ${Mpris.artist}`;
            }

            HoverHandler {
                cursorShape: hovered && Qt.CursorShape.PointingHandCursor
            }

            TapHandler {
                acceptedButtons: Qt.LeftButton | Qt.RightButton

                onTapped: (eventPoint, button) => _onClicked(button)

                function _onClicked(button): void {
                    if (button === Qt.RightButton) {
                        Mpris.togglePlaying();
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
                        Mpris.previous();
                    }

                    if (delta > 0) {
                        Mpris.next();
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
