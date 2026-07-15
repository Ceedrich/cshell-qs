import QtQuick

import qs.services
import qs.widgets

import Quickshell.Bluetooth as BT

CBarItem {
    id: root
    visible: BluetoothService.connectedDevices.length > 0

    property BT.BluetoothDevice device: BluetoothService.connectedDevices[0]

    property bool isAudio: device.icon.includes("audio")

    text: `${isAudio ? "󰂰" : "󰂯"} ${device?.name ?? ""}`
    underline: true

    clickEnabled: false
}
