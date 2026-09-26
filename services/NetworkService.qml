pragma Singleton

import Quickshell
import Quickshell.Networking

import qs.utils

Singleton {
    property list<WifiDevice> wifiDevices: Networking.wifiEnabled ? Networking.devices.values.filter(d => d.type === DeviceType.Wifi) : []
    property list<WiredDevice> wiredDevices: Networking.devices.values.filter(d => d.type === DeviceType.Wired)

    property list<WifiNetwork> wifiNetworks: wifiDevices.reduce((acc, dev) => acc.concat(dev.networks.values), [])

    function setScanning(scanning: bool) {
        for (const dev of wifiDevices) {
            dev.scannerEnabled = scanning;
        }
    }

    function enableScanning() {
        setScanning(true);
    }

    function disableScanning() {
        setScanning(false);
    }

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
