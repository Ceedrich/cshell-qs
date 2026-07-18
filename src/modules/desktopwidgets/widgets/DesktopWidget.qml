import QtQuick

import qs.services
import qs.widgets.ContextMenu
import qs.utils

Item {
    id: root
    visible: enabled

    required property string identifier
    property string name: identifier

    property var stateData: ({
            x,
            y,
            enabled
        })

    property list<CContextMenuItem> contextMenuModel: [
        CContextMenuItem {
            label: root.name
            type: CContextMenuItem.Label
        },
        CContextMenuItem {
            label: "Hide"
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

    TapHandler {
        acceptedButtons: Qt.RightButton
        onTapped: p => contextMenu.openAtPosition(p.pressPosition.x, p.pressPosition.y)
    }

    function saveState() {
        SettingsService.state.desktopWidgets[identifier] = stateData;
        SettingsService.triggerStateSave();
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
            root.enabled = SettingsService.state.desktopWidgets[root.identifier]?.enabled ?? true;
            root.x = SettingsService.state.desktopWidgets[root.identifier]?.x ?? 0;
            root.y = SettingsService.state.desktopWidgets[root.identifier]?.y ?? 0;
        }
    }
}
