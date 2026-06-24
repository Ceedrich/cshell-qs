pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import qs.widgets
import qs.config

Popup {
    id: root
    property list<CContextMenuItem> model: []

    padding: Config.spacing

    implicitWidth: 280

    background: Rectangle {
        color: Colors.base
        border.width: Config.border.width
        border.color: Colors.overlay2
        radius: Config.border.radius
    }

    ColumnLayout {
        anchors.fill: parent
        Repeater {
            model: root.model

            CButton {
                id: item
                enabled: (!modelData.isLabel) && (!modelData.isDivider)
                Layout.fillWidth: true
                required property CContextMenuItem modelData
                onClicked: {
                    modelData.triggered();
                    root.close();
                }

                implicitHeight: layout.implicitHeight
                implicitWidth: layout.implicitWidth

                RowLayout {
                    id: layout
                    CCheckbox {
                        Layout.preferredWidth: 16
                        Layout.preferredHeight: 16
                        visible: item.modelData.isCheckbox
                        checkState: item.modelData.isChecked ? Qt.Checked : Qt.Unchecked
                    }

                    CText {
                        visible: !item.modelData.isDivider
                        font.bold: item.modelData.isLabel
                        text: item.modelData.label
                    }
                }
            }
        }
    }

    function openAtPosition(x: real, y: real) {
        root.x = x;
        root.y = y;
        open();
    }
}
