import QtQuick
import QtQuick.Layouts

import qs.widgets
import qs.services

Item {
    id: root

    property bool expanded: false

    implicitWidth: layout.implicitWidth
    implicitHeight: layout.implicitHeight

    ColumnLayout {
        id: layout
        width: parent.width
        RowLayout {
            Layout.fillWidth: true
            CSlider {
                from: 0
                to: 100
                Layout.fillWidth: true
                value: VolumeService.volume * 100
                onInteraction: v => VolumeService.setVolume(v / 100)
            }

            CTextButton {
                text: root.expanded ? "󰁅" : "󰁝"
                onClicked: root.expanded = !root.expanded
            }
        }

        Item {
            id: content
            visible: root.expanded
            Layout.fillWidth: true
            implicitHeight: contentLayout.implicitHeight

            property var debug: console.log(VolumeService.streams.length)

            ColumnLayout {
                id: contentLayout
                Repeater {
                    model: VolumeService.streams

                    RowLayout {
                        id: stream
                        required property var modelData
                        property var debug: console.log(JSON.stringify(stream.modelData, null, 2))
                    }
                }
            }
        }
    }
}
