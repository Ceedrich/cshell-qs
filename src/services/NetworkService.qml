pragma Singleton

import Quickshell
import Quickshell.Networking

import qs.utils

Singleton {
    property list<WifiDevice> wifiDevices: Networking.wifiEnabled ? Networking.devices.values.filter(d => d.type === DeviceType.Wifi) : []
    property list<WiredDevice> wiredDevices: Networking.devices.values.filter(d => d.type === DeviceType.Wired)

    function getWirelessIcon(network: WifiNetwork): string {
        // TODO: look into wifi security types
        return Utils.select_from_list(network.signalStrength, ["󰤟", "󰤢", "󰤥", "󰤨"]);
    }

    function getWiredIcon(_network: Network): string {
        return "󰛳";
    }

    function getNetworkIcon(network: Network): string {
        switch (network.device.type) {
        case DeviceType.Wired:
            return getWiredIcon(network);
        case DeviceType.Wifi:
            return getWirelessIcon(network);
        }
    }
}
