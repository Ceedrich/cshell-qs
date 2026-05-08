import Quickshell.Services.Mpris
import QtQuick
import QtQuick.Layouts

import qs.widgets
import qs.config

BarPill {
    visible: Mpris.players.values.length > 0
    enabled: visible
    RowLayout {
        CTextNoHandlers {
            id: textRoot
            property MprisPlayer player: {
                Mpris.players.values[0];
            }
            property int max_length: 30

            readonly property string icon: getPlayerIcon(player)

            visible: player != null

            text: textMetrics.elidedText
            color: Colors.overlay1

            function getPlayerIcon(player: MprisPlayer): string {
                switch (player?.desktopEntry) {
                case "spotify":
                    return "󰓇";
                default:
                    return "󰐊";
                }
            }

            TextMetrics {
                id: textMetrics
                font: textRoot.font

                elideWidth: Config.maxMprisWidth
                elide: Qt.ElideRight

                text: textRoot.formatText()
            }

            function formatText(): string {
                const title = player?.trackTitle;
                const album = player?.trackAlbum;
                const artist = player?.trackArtist;

                return `${icon} ${title} - ${artist}`;
            }

            HoverHandler {
                cursorShape: hovered && Qt.CursorShape.PointingHandCursor
            }

            TapHandler {
                acceptedButtons: Qt.LeftButton | Qt.RightButton

                onTapped: (eventPoint, button) => _onClicked(button)

                function _onClicked(button): void {
                    if (button === Qt.RightButton) {
                        textRoot.player.togglePlaying();
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
                        textRoot.player.previous();
                    }

                    if (delta > 0) {
                        textRoot.player.next();
                    }

                    handled = true;
                }
            }
        }

        BarPopup {
            id: playerPopup
            barItem: textRoot

            MprisPopup {
                popup: playerPopup
                player: textRoot.player
            }
        }
    }
}
