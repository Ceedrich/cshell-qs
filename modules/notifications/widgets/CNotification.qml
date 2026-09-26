import QtQuick
import QtQuick.Layouts
import Quickshell.Widgets

import qs.widgets
import qs.config
import qs.modules.notifications

WrapperRectangle {
    id: root
    required property NotificationData notification

    margin: Config.spacing

    color: Colors.base
    border.color: root.notification.isCritical ? Colors.red : Colors.overlay2
    border.width: Config.border.width
    radius: 10

    signal expired
    signal clicked

    Connections {
        target: root.notification.expireTimer
        function onTriggered() {
            root.expired();
        }
    }

    RowLayout {
        id: layout

        TapHandler {
            id: tap
            acceptedButtons: Qt.LeftButton
            onTapped: root.clicked()
        }

        HoverHandler {
            id: hover
            onHoveredChanged: {
                if (hovered) {
                    root.notification.expireTimer.stop();
                } else {
                    root.notification.expireTimer.start();
                }
            }
        }

        Item {
            Layout.alignment: Qt.AlignTop
            Layout.preferredWidth: 32
            Layout.preferredHeight: 32

            Image {
                id: image
                anchors.fill: parent
                visible: source.toString() != ""
                source: root.notification.image
            }

            Image {
                id: fallbackImage
                visible: !image.visible
                source: "image://icon/dialog-information-symbolic"
                anchors.fill: parent
            }
        }

        ColumnLayout {
            Layout.alignment: Qt.AlignVCenter
            RowLayout {
                CText {
                    Layout.fillWidth: true
                    text: root.notification.summary
                    font.bold: true
                }
                Item {
                    Layout.fillWidth: true
                }
                CText {
                    text: root.notification.timeString
                    muted: true
                }
            }

            CText {
                visible: text != ""
                Layout.fillWidth: true
                text: root.notification.body
                wrapMode: Text.WordWrap
                maximumLineCount: 2
            }
        }
    }
}
