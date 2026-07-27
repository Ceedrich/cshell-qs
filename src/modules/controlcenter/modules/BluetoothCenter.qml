import QtQuick.Layouts
import QtQuick

import Quickshell.Bluetooth
import Quickshell

import qs.services
import qs.widgets
import qs.config

import qs.modules.controlcenter.widgets

ColumnLayout {
    id: root

    RowLayout {
        CText {
            text: "Bluetooth"
            font.bold: true
            font.pixelSize: Config.font.headingPixelSize
        }
        Item {
            Layout.fillWidth: true
        }
        CTextButton {
            property int btState: BluetoothService.defaultAdapter?.state ?? 0 // qmllint disable unresolved-type
            text: {
                switch (btState) {
                case BluetoothAdapterState.Enabled:
                    return "disable";
                case BluetoothAdapterState.Disabled:
                    return "enable";
                case BluetoothAdapterState.Blocked:
                    return "blocked";
                default:
                    return BluetoothAdapterState.toString(btState).toLowerCase() + "...";
                }
            }

            enabled: btState !== BluetoothAdapterState.Blocked && (btState === BluetoothAdapterState.Enabled || btState === BluetoothAdapterState.Disabled)
            disabled: !enabled

            onClicked: BluetoothService.defaultAdapter.enabled = !BluetoothService.defaultAdapter.enabled
        }
        CTextButton {
            text: BluetoothService.defaultAdapter?.discovering ? "stop discovering" : "discover"
            onClicked: BluetoothService.defaultAdapter.discovering = !BluetoothService.defaultAdapter.discovering
        }
    }

    Repeater {
        model: BluetoothService.devices

        delegate: BluetoothDeviceRow {
            required property var modelData
            device: modelData
        }
    }
}
