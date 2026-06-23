import QtQuick

QtObject {
    property string label: ""
    enum Type {
        Normal,
        Checkbox,
        Divider
    }

    property int type: CContextMenuItem.Normal
    property bool isChecked: false

    readonly property bool isCheckbox: type === CContextMenuItem.Checkbox
    readonly property bool isDivider: type === CContextMenuItem.Divider

    signal triggered
}
