import QtQuick
import QtQuick.Layouts

import Quickshell.Networking

import qs.services
import qs.widgets

RowLayout {
    id: wifiNetwork
    required property WifiNetwork network

    Layout.fillWidth: true

    CText {
        text: NetworkService.getWirelessIcon(wifiNetwork.network)
    }

    CText {
        text: wifiNetwork.network.name
        Layout.fillWidth: true
    }

    Item {
        Layout.fillWidth: true
    }

    CTextButton {
        visible: wifiNetwork.network.known
        text: "forget"
        onClicked: wifiNetwork.network.forget()
    }

    NetworkConnectionButton {
        network: wifiNetwork.network
    }
}
