import QtQuick

QtObject {
    property string label: ""
    enum Type {
        Normal,
        Label,
        Checkbox,
        Divider
    }

    property int type: CContextMenuItem.Normal
    property bool isChecked: false

    readonly property bool isCheckbox: type === CContextMenuItem.Checkbox
    readonly property bool isDivider: type === CContextMenuItem.Divider
    readonly property bool isLabel: type === CContextMenuItem.Label

    signal triggered
}
