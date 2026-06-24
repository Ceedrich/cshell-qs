import QtQuick

import qs.services
import qs.widgets.ContextMenu
import qs.utils

Item {
    id: root
    visible: enabled

    required property string identifier
    property var stateData: ({
            x,
            y,
            enabled
        })

    property list<CContextMenuItem> contextMenuModel: [
        CContextMenuItem {
            label: "disable"
            onTriggered: root.disable()
        }
    ]

    objectName: identifier

    DragHandler {
        id: handler
        onActiveChanged: {
            if (!active) {
                root.saveState();
            }
        }
    }

    CContextMenu {
        id: contextMenu
        model: root.contextMenuModel
    }

    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.RightButton
        onClicked: contextMenu.openAtPosition(mouseX, mouseY)
    }

    function saveState() {
        SettingsService.state.desktopWidgets[identifier] = stateData;
        SettingsService.triggerSave();
    }

    function toggleEnabled() {
        enabled = !enabled;
        saveState();
    }
    // qmlformat off
    function enable() { if (!enabled) toggleEnabled(); }
    function disable() { if (enabled) toggleEnabled(); }
    // qmlformat on

    Connections {
        target: SettingsService
        function onStateLoaded() {
            root.enabled = Utils.valueOrDefault(SettingsService.state.desktopWidgets[root.identifier]?.enabled, true);
            root.x = Utils.valueOrDefault(SettingsService.state.desktopWidgets[root.identifier]?.x, 0);
            root.y = Utils.valueOrDefault(SettingsService.state.desktopWidgets[root.identifier]?.y, 0);
        }
    }
}
