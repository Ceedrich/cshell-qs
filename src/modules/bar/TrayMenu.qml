pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts

import qs.config
import qs.widgets

PopupWindow {
    id: root
    required property var trayItem
    property var anchorItem

    readonly property QsMenuHandle menu: trayItem ? trayItem.menu : null
    readonly property int menuWidth: 280

    implicitWidth: menuWidth
    implicitHeight: rect.implicitHeight
    visible: false
    anchor.item: anchorItem

    grabFocus: true

    color: "transparent"

    function showAt(anchorItem: Item) {
        if (anchorItem) {
            this.anchorItem = anchorItem;
        }
        visible = true;
    }

    function close() {
        visible = false;
    }

    QsMenuOpener {
        id: opener
        menu: root.menu
    }

    WrapperRectangle {
        id: rect
        color: Colors.base
        radius: Config.border.radius
        border.color: Colors.overlay1
        border.width: Config.border.width

        width: parent.width

        margin: Config.spacing

        ColumnLayout {
            id: menuColumn
            spacing: Config.spacing

            Repeater {
                // Make a copy of the values why?
                model: root.removeDuplicateSeparators(opener.children.values)

                delegate: Rectangle {
                    id: entry
                    required property QsMenuEntry modelData

                    readonly property bool isSeparator: modelData?.isSeparator || false

                    Layout.fillWidth: true
                    Layout.preferredHeight: isSeparator ? 8 : text.implicitHeight

                    color: "transparent"

                    CDivider {
                        visible: entry.isSeparator
                        orientation: CDivider.Orientation.Horizontal
                        anchors.centerIn: entry
                    }

                    CButton {
                        id: text
                        visible: !entry.isSeparator

                        width: entry.width

                        text: (entry.modelData?.hasChildren ? ">" : " ") + (entry.modelData?.text || "")
                        disabled: !entry.modelData?.enabled

                        onClicked: {
                            if (disabled) {
                                return;
                            }
                            root.close();
                            entry.modelData?.triggered();
                        }
                    }
                }
            }
        }
    }

    function removeDuplicateSeparators(arr) {
        return arr.reduce((list, next) => (list.slice(-1)[0]?.isSeparator && next?.isSeparator) ? list : [...list, next], []);
    }
}
