import QtQuick
import QtQuick.Layouts

import Quickshell
import Quickshell.Bluetooth
import Quickshell.Widgets

import qs.widgets

RowLayout {
    id: device
    required property BluetoothDevice device

    IconImage {
        source: device.device.icon ? Quickshell.iconPath(device.device.icon) : "image://icon/bluetooth"
        implicitSize: 20
    }

    CText {
        text: device.device.name
        Layout.fillWidth: true
    }

    Item {
        Layout.fillWidth: true
    }

    CTextButton {
        property int btState: device.device.state // qmllint disable unresolved-type
        text: {
            switch (btState) {
            case BluetoothDeviceState.Connected:
                return "disconnect";
            case BluetoothDeviceState.Disconnected:
                return "connect";
            default:
                return BluetoothDeviceState.toString(btState).toLowerCase() + "...";
            }
        }

        enabled: btState === BluetoothDeviceState.Connected || btState === BluetoothDeviceState.Disconnected
        disabled: !enabled

        onClicked: device.device.connected ? device.device.disconnect() : device.device.connect()
    }

    CTextButton {
        text: device.device.trusted ? "untrust" : "trust"
        onClicked: device.device.trusted = !device.device.trusted
    }

    CTextButton {
        text: device.device.paired ? "forget" : "pair"
        onClicked: device.device.paired ? device.device.forget() : device.device.pair()
    }
}
