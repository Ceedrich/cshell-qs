import QtQuick
import QtQuick.Layouts

import qs.services
import qs.widgets
import qs.config

RowLayout {
    id: root
    required property QtObject popup
    spacing: 0
    GridLayout {
        Layout.preferredWidth: Config.mprisPopupWidth

        columnSpacing: Config.spacing

        Image {
            id: image

            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: 100
            Layout.preferredHeight: 100
            Layout.row: 0
            Layout.column: 0

            source: MprisService.trackArtUrl

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    root.popup.visible = false;
                    MprisService.raise();
                }
            }
        }

        ColumnLayout {
            visible: MprisService.available
            Layout.alignment: Qt.AlignVCenter
            spacing: 0

            CText {
                Layout.fillWidth: true
                text: MprisService.title
                font.pixelSize: Config.fontSize * 1.25
            }

            CText {
                Layout.fillWidth: true

                text: MprisService.artist
            }

            CText {
                Layout.fillWidth: true

                text: MprisService.album
            }
        }

        RowLayout {
            id: controls
            Layout.row: 1
            Layout.column: 0
            Layout.alignment: Qt.AlignHCenter
            spacing: Config.spacing

            CTextButton {
                text: "󰒮"
                font.pixelSize: 1.25 * Config.fontSize
                onClicked: MprisService.previous()
            }

            CTextButton {
                text: MprisService.isPlaying ? "󰏤" : "󰐊"
                font.pixelSize: 1.25 * Config.fontSize
                onClicked: MprisService.togglePlaying()
            }

            CTextButton {
                text: "󰒭"
                font.pixelSize: 1.25 * Config.fontSize
                onClicked: MprisService.next()
            }
        }

        RowLayout {
            id: positionDisplay
            Layout.row: 1
            Layout.column: 1
            visible: MprisService.progressAvailable

            property bool showRemaining: false

            CSlider {
                id: slider
                Layout.fillWidth: true
                value: MprisService.player?.position || 0
                from: 0
                to: MprisService.player?.length || 0
                onMoved: () => MprisService.player.position = value

                FrameAnimation {
                    running: slider.visible
                    onTriggered: () => MprisService.player.positionChanged()
                }
            }

            CTextButton {
                topPadding: 0
                bottomPadding: 0
                leftPadding: 0
                rightPadding: 0
                text: {
                    if (positionDisplay.showRemaining) {
                        const remaining = root.formatMinutes(MprisService.player?.length - (MprisService.player?.position || 0));
                        return `-${remaining} `;
                    } else {
                        const text = root.formatMinutes(MprisService.player?.position || 0);
                        return ` ${text} `;
                    }
                }
                onClicked: positionDisplay.showRemaining = !positionDisplay.showRemaining
            }
        }

        CComboBox {
            visible: MprisService.players.length > 1

            onActivated: i => MprisService.setPlayer(MprisService.players[i])

            enabled: visible
            Layout.row: 2
            Layout.columnSpan: 2
            Layout.alignment: Qt.AlignHCenter
            model: MprisService.players.map(p => p.identity)
        }
    }
    function formatMinutes(seconds: real): string {
        const m = String(Math.floor(seconds / 60)).padStart(2, '0');
        const s = String(Math.floor(seconds % 60)).padStart(2, '0');

        return `${m}:${s}`;
    }
}
