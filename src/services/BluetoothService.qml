pragma Singleton
import Quickshell
import Quickshell.Bluetooth

Singleton {
    readonly property BluetoothAdapter defaultAdapter: Bluetooth.defaultAdapter // qmllint disable unresolved-type
    // TODO: find right filter conditions
    property list<BluetoothDevice> devices: defaultAdapter?.devices.values.filter(d => d.deviceName) ?? [] // qmllint disable unresolved-type
    property list<BluetoothDevice> connectedDevices: devices.filter(d => d.connected)

    readonly property int _state: defaultAdapter?.state ?? 0 // qmllint disable unresolved-type
    readonly property bool canToggleEnabled: _state !== BluetoothAdapterState.Blocked && (_state === BluetoothAdapterState.Enabled || _state === BluetoothAdapterState.Disabled)

    function toggleEnabled() {
        if (!canToggleEnabled) {
            return;
        }

        defaultAdapter.enabled = !defaultAdapter.enabled;
    }
}
