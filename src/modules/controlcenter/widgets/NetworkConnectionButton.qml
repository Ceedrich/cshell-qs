import Quickshell.Networking

import qs.widgets

CTextButton {
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
