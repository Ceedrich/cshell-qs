pragma Singleton
import Quickshell
import Quickshell.Bluetooth

Singleton {
    property list<BluetoothDevice> devices: Bluetooth.devices.values
    property list<BluetoothDevice> connectedDevices: devices.filter(d => d.connected)
}
