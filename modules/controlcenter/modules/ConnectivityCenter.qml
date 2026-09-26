pragma ComponentBehavior: Bound

import Quickshell.Widgets
import Quickshell.Networking
import Quickshell.Bluetooth
import QtQuick
import QtQuick.Layouts

import qs.config
import qs.widgets
import qs.services

import qs.modules.controlcenter.widgets

WrapperRectangle {
    id: root
    color: Colors.surface0
    radius: Config.border.radius
    margin: Config.margin

    signal expanded(listType: int)
    signal closed(listType: int)

    enum ListType {
        None,
        Wifi,
        Bluetooth
    }

    onExpanded: listType => {
        if (listType === ConnectivityCenter.Bluetooth) {
            BluetoothService.defaultAdapter.discovering = true;
        } else if (listType === ConnectivityCenter.Wifi) {
            NetworkService.enableScanning();
        }
    }

    onClosed: listType => {
        if (listType === ConnectivityCenter.Bluetooth) {
            BluetoothService.defaultAdapter.discovering = false;
        } else if (listType === ConnectivityCenter.Wifi) {
            NetworkService.disableScanning();
        }
    }

    property int listType: ConnectivityCenter.None

    ColumnLayout {
        GridLayout {
            columns: 2
            uniformCellWidths: true
            uniformCellHeights: true

            ConnectivityButton {
                icon: BluetoothService.defaultAdapter?.enabled ? "󰂯" : "󰂲"
                onClicked: BluetoothService.toggleEnabled()
                enabled: BluetoothService.canToggleEnabled
                disabled: !enabled

                onExpanded: BluetoothService.defaultAdapter.discovering = true
                onClosed: BluetoothService.defaultAdapter.discovering = false

                listType: ConnectivityCenter.Bluetooth

                text: "Bluetooth"
            }

            ConnectivityButton {
                icon: Networking.wifiEnabled ? "󰖩" : "󰖪"
                text: "Wifi"
                listType: ConnectivityCenter.Wifi
                onClicked: Networking.wifiEnabled = !Networking.wifiEnabled
            }
        }

        CSeparator {
            visible: root.listType !== ConnectivityCenter.None
        }

        ColumnLayout {
            visible: root.listType !== ConnectivityCenter.None && connectivityList !== []
            CText {
                visible: connectivityList.model.length === 0
                text: "empty"
                font.italic: true
            }
            Repeater {
                id: connectivityList

                states: [
                    State {
                        when: root.listType === ConnectivityCenter.Bluetooth
                        PropertyChanges {
                            connectivityList.model: BluetoothService.devices
                            connectivityList.delegate: bluetoothRow
                        }
                    },
                    State {
                        when: root.listType === ConnectivityCenter.Wifi
                        PropertyChanges {
                            connectivityList.model: NetworkService.wifiNetworks
                            connectivityList.delegate: networkRow
                        }
                    }
                ]

                model: []
                delegate: null
            }
        }
    }

    property Component _bluetoothRow: Component {
        id: bluetoothRow
        BluetoothDeviceRow {
            required property var modelData
            device: modelData
        }
    }

    property Component _networkRow: Component {
        id: networkRow
        WifiNetworkRow {
            required property var modelData
            network: modelData
        }
    }

    component ConnectivityButton: RowLayout {
        id: btn
        required property int listType
        property alias text: btnText.text
        property alias icon: btnIcon.text
        property alias disabled: togglebtn.disabled

        Layout.fillWidth: true

        signal clicked
        signal expanded
        signal closed

        CButton {
            id: togglebtn
            Layout.fillWidth: true
            enabled: btn.enabled

            content: RowLayout {
                CText {
                    id: btnIcon
                }

                CText {
                    id: btnText
                }

                Item {
                    Layout.fillWidth: true
                }
            }
            onClicked: btn.clicked()
        }

        CTextButton {
            text: "󰁅"
            onClicked: {
                if (root.listType === ConnectivityCenter.None) {
                    root.listType = btn.listType;
                    root.expanded(btn.listType);
                } else if (root.listType === btn.listType) {
                    root.closed(btn.listType);
                    root.listType = ConnectivityCenter.None;
                } else {
                    root.closed(root.listType);
                    root.listType = btn.listType;
                    root.expanded(btn.listType);
                }
            }
        }
    }
}
