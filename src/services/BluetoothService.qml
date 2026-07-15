pragma Singleton
import Quickshell
import Quickshell.Bluetooth

Singleton {
    property list<BluetoothDevice> devices: Bluetooth.devices.values
    property list<BluetoothDevice> connectedDevices: devices.filter(d => d.connected)

    property var debug: {
        console.log("---devices");
        for (const d of devices) {
            console.log(d.name);
        }

        console.log("---connected devices");
        for (const d of connectedDevices) {
            console.log(d.name);
        }
    }
}
