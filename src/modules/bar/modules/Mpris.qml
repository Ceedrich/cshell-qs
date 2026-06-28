import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts

import qs.services
import qs.widgets
import qs.config

ClippingWrapperRectangle {
    id: root
    readonly property bool isOpen: hover.hovered

    visible: MprisService.available
    enabled: visible

    margin: Config.spacing
    color: Colors.base
    radius: Config.border.radius
    border.width: 1
    border.color: Colors.overlay1

    Behavior on radius {
        Config.NumberAnimationSimple {}
    }

    HoverHandler {
        id: hover
    }

    Item {
        implicitWidth: root.isOpen ? openContent.implicitWidth : closedContent.implicitWidth
        implicitHeight: root.isOpen ? openContent.implicitHeight : closedContent.implicitHeight

        transformOrigin: Item.Top

        Behavior on implicitWidth {
            Config.NumberAnimationSimple {}
        }
        Behavior on implicitHeight {
            Config.NumberAnimationSimple {}
        }

        RowLayout {
            id: closedContent
            opacity: root.isOpen ? 0 : 1
            Behavior on opacity {
                Config.NumberAnimationSimple {}
            }

            ClippingRectangle {
                Layout.preferredWidth: 20
                Layout.preferredHeight: 20
                radius: 6
                color: "transparent"

                CText {
                    anchors.centerIn: parent
                    text: MprisService.playerIcon
                }
                Image {
                    anchors.centerIn: parent
                    width: 20
                    height: 20
                    source: MprisService.trackArtUrl
                }
            }

            CText {
                text: formatText()
                color: Colors.overlay1
                Layout.maximumWidth: Config.maxMprisWidth

                function formatText(): string {
                    return `${MprisService.title} - ${MprisService.artist}`;
                }
            }
        }
        RowLayout {
            id: openContent
            opacity: root.isOpen ? 1 : 0

            Behavior on opacity {
                Config.NumberAnimationSimple {}
            }

            spacing: 0
            GridLayout {
                Layout.preferredWidth: Config.mprisPopupWidth

                columnSpacing: Config.spacing

                Item {
                    Layout.preferredWidth: 100
                    Layout.preferredHeight: 100
                    Layout.row: 0
                    Layout.column: 0

                    Image {
                        id: image
                        anchors.fill: parent

                        Layout.alignment: Qt.AlignHCenter

                        source: MprisService.trackArtUrl

                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            onClicked: {
                                MprisService.raise();
                            }
                        }
                    }
                    CText {
                      anchors.centerIn: parent
                      width: parent.width
                      wrapMode: Text.WordWrap
                      horizontalAlignment: Text.AlignHCenter
                      muted: true
                      visible: text !== ""
                      text: {
                        switch (image.State) {
                          case Image.Error: 
                            return "[error loading image]"
                            break
                          case Image.Ready:
                            return ""
                            break
                          case Image.Loading:
                            return "[loading...]"
                            break
                          default:
                            return "[image not available]"
                        }
                      }
                    }
                }

                ColumnLayout {
                    visible: MprisService.available
                    Layout.alignment: Qt.AlignVCenter
                    spacing: 0

                    CText {
                        Layout.fillWidth: true
                        text: MprisService.title || "[title not available]"
                        muted: MprisService.title === ""
                        font.pixelSize: Config.fontSize * 1.25
                    }

                    CText {
                        Layout.fillWidth: true

                        text: MprisService.artist || "[artist not available]"
                        muted: MprisService.artist === ""
                    }

                    CText {
                        Layout.fillWidth: true

                        text: MprisService.album || "[album not available]"
                        muted: MprisService.album === ""
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
                        text: positionDisplay.showRemaining ? `-${MprisService.formattedRemainingTime} ` : ` ${MprisService.formattedTime} `
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
    }
}
