import QtQuick
import QtQuick.Layouts
import Quickshell.Networking
import Quickshell

import qs.widgets
import qs.config
import qs.services

import qs.modules.controlcenter.widgets

ColumnLayout {
    RowLayout {
        CText {
            text: "Networks"
            font.bold: true
            font.pixelSize: Config.font.headingPixelSize
        }
        Item {
            Layout.fillWidth: true
        }

        CTextButton {
            text: Networking.wifiEnabled ? "󰖩" : "󰖪"
            onClicked: Networking.wifiEnabled = !Networking.wifiEnabled
        }
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
                    Layout.fillWidth: true
                }

                Item {
                    Layout.fillWidth: true
                }

                NetworkConnectionButton {
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
                    Layout.fillWidth: true
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
                delegate: WifiNetworkRow {
                    required property var modelData
                    network: modelData
                }
            }
            CSeparator {}
        }
    }
}
