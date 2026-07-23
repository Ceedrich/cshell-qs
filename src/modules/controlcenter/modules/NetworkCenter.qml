import QtQuick
import QtQuick.Layouts
import Quickshell.Networking
import Quickshell

import qs.widgets
import qs.config
import qs.services

ColumnLayout {
    CText {
        text: "Networks"
        font.bold: true
    }

    Repeater {
        model: ScriptModel {
            values: NetworkService.wiredDevices.filter(d => d.network != null)
        }
        delegate: ColumnLayout {
            id: wiredDevice
            required property WiredDevice modelData
            property Network network: modelData.network // qmllint disable unresolved-type
            RowLayout {
                CText {
                    text: "Wired Connection"
                }
                CText {
                    text: wiredDevice.modelData.name
                    color: Colors.overlay2
                }

                Item {
                    Layout.fillWidth: true
                }

                ConnectionButton {
                    network: wiredDevice.network
                }
            }
            CSeparator {}
        }
    }

    Repeater {
        model: NetworkService.wifiDevices
        delegate: ColumnLayout {
            id: wifiDevice
            required property WifiDevice modelData

            RowLayout {
                CText {
                    text: "Wifi"
                    font.bold: true
                }
                CText {
                    text: wifiDevice.modelData.name
                    color: Colors.overlay2
                }
                Item {
                    Layout.fillWidth: true
                }
                CTextButton {
                    text: wifiDevice.modelData.scannerEnabled ? "show known" : "show available"
                    onClicked: wifiDevice.modelData.scannerEnabled = !wifiDevice.modelData.scannerEnabled
                }
            }

            Repeater {
                model: wifiDevice.modelData.networks
                delegate: RowLayout {
                    id: wifiNetwork
                    required property WifiNetwork modelData

                    Layout.fillWidth: true

                    CText {
                        text: NetworkService.getWirelessIcon(wifiNetwork.modelData)
                    }

                    CText {
                        text: wifiNetwork.modelData.name
                    }

                    Item {
                        Layout.fillWidth: true
                    }

                    CTextButton {
                        visible: wifiNetwork.modelData.known
                        text: "forget"
                        onClicked: wifiNetwork.modelData.forget()
                    }

                    ConnectionButton {
                        network: wifiNetwork.modelData
                    }
                }
            }
        }
    }
    CSeparator {}

    component ConnectionButton: CTextButton {
        required property Network network

        text: {
            switch (network.state // qmllint disable unresolved-type
            ) {
            case ConnectionState.Connected:
                return "disconnect";
            case ConnectionState.Disconnected:
                return "connect";
            default:
                return `${ConnectionState.toString(network.state).toLowerCase()}...`; // qmllint disable unresolved-type
            }
        }
        enabled: network.state === ConnectionState.Connected || network.state === ConnectionState.Disconnected // qmllint disable unresolved-type
        disabled: !enabled
        onClicked: network.connected ? network.disconnect() : network.connect()
    }
}
