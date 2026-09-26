// heavily inspired by <https://github.com/noctalia-dev/noctalia-shell/blob/main/Modules/Bar/Extras/TrayMenu.qml> licenced MIT

pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Shapes
import QtQuick.Layouts

import qs.config
import qs.widgets

PopupWindow {
    id: root

    property var trayItem
    property var anchorItem: null

    property int anchorX
    property int anchorY
    property bool isSubMenu: false

    readonly property QsMenuHandle menu: trayItem ? trayItem.menu : null
    readonly property int menuWidth: 280

    implicitWidth: menuWidth
    implicitHeight: rect.implicitHeight
    visible: false

    anchor.item: anchorItem
    anchor.rect.x: anchorX
    anchor.rect.y: anchorY

    grabFocus: true

    color: "transparent"

    function showAt(anchorItem: Item, x: real, y: real) {
        if (!anchorItem) {
            console.warn("could not create context menu");
            return;
        }

        this.anchorItem = anchorItem;
        anchorX = x;
        anchorY = y;

        visible = true;
    }

    function hideMenu() {
        visible = false;

        // close submenus recursively
        for (const child of menuColumn.children) {
            if (child?.subMenu) {
                child.subMenu.hideMenu();
                child.subMenu.destroy();
                child.subMenu = null;
            }
        }
    }

    // clean up when hidden
    onVisibleChanged: {
        if (!visible) {
            hideMenu();
        }
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
                    property var subMenu: null

                    readonly property bool isSeparator: modelData?.isSeparator || false

                    Layout.fillWidth: true
                    Layout.preferredHeight: isSeparator ? 8 : content.implicitHeight

                    color: "transparent"

                    CDivider {
                        visible: entry.isSeparator
                        orientation: CDivider.Orientation.Horizontal
                        anchors.centerIn: entry
                    }

                    CButton {
                        id: content
                        visible: !entry?.isSeparator
                        width: parent.width
                        disabled: !entry.modelData?.enabled

                        onLongHover: {
                            if (!entry.subMenu && entry.modelData?.hasChildren) {
                                entry.openSubMenu();
                            }
                        }

                        onClicked: {
                            if (entry.modelData?.hasChildren) {
                                entry.openSubMenu();
                            } else {
                                root.hideMenu();
                                entry.modelData?.triggered();
                            }
                        }

                        content: RowLayout {
                            spacing: 8

                            Item {
                                id: iconContainer
                                Layout.preferredWidth: 16
                                Layout.preferredHeight: 16

                                readonly property bool isCheckbox: entry.modelData?.buttonType === QsMenuButtonType.CheckBox
                                readonly property bool isRadioButton: entry.modelData?.buttonType === QsMenuButtonType.RadioButton
                                readonly property bool isIcon: entry.modelData?.buttonType === QsMenuButtonType.None && entry.modelData?.icon

                                CRadioButton {
                                    visible: iconContainer.isRadioButton
                                    anchors.fill: parent

                                    checked: entry.modelData?.checkState || false
                                }

                                CCheckbox {
                                    visible: iconContainer.isCheckbox
                                    anchors.fill: parent

                                    checkState: entry.modelData?.checkState || 0
                                }

                                IconImage {
                                    visible: iconContainer.isIcon
                                    anchors.fill: parent

                                    source: entry.modelData?.icon || ""
                                }
                            }

                            CText {
                                id: text

                                Layout.fillWidth: true

                                color: content.disabled ? Colors.overlay1 : defaultColor

                                topPadding: 0
                                bottomPadding: 0
                                leftPadding: 0
                                rightPadding: 0
                                text: (entry.modelData?.text || "")
                            }

                            Shape {
                                id: shape
                                visible: (entry.modelData?.hasChildren ?? false)
                                implicitWidth: 8
                                implicitHeight: 10
                                ShapePath {
                                    strokeWidth: 0
                                    fillColor: Colors.text
                                    startX: 0
                                    startY: 0
                                    PathLine {
                                        x: shape.width
                                        y: shape.height / 2
                                    }
                                    PathLine {
                                        x: 0
                                        y: shape.height
                                    }
                                    PathLine {
                                        x: 0
                                        y: 0
                                    }
                                }
                            }
                        }
                    }

                    function openSubMenu() {
                        if (subMenu) {
                            // Close submenu if it exists
                            subMenu.hideMenu();
                            subMenu.destroy();
                            subMenu = null;
                        }

                        // close other submenus
                        for (const child of menuColumn.children) {
                            if (child !== entry && child.subMenu) {
                                child.subMenu.hideMenu();
                                child.subMenu.destroy();
                                child.subMenu = null;
                            }
                        }

                        entry.subMenu = Qt.createComponent("TrayMenu.qml").createObject(root, {
                            menu: modelData,
                            isSubMenu: true
                        });

                        if (entry.subMenu) {
                            entry.subMenu.anchorItem = entry;
                            entry.subMenu.anchorY = 0;
                            entry.subMenu.anchorX = -root.menuWidth;
                            entry.subMenu.visible = true;
                        }
                    }
                }
            }
        }
    }

    function removeDuplicateSeparators(arr) {
        arr = arr.reduce((list, next) => (list.slice(-1)[0]?.isSeparator && next?.isSeparator) ? list : [...list, next], []);
        if (arr.slice(-1)[0]?.isSeparator) {
            arr.pop();
        }
        return arr;
    }
}
