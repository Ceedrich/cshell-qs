import QtQuick
import Quickshell.Widgets

import qs.services
import qs.utils

WrapperRectangle {
    id: root
    visible: enabled

    required property string identifier
    objectName: identifier

    color: "transparent"

    property var stateData: ({
            x,
            y,
            enabled
        })

    DragHandler {
        id: handler
        onActiveChanged: {
            if (!active) {
                root.saveState();
            }
        }
    }

    function saveState() {
        SettingsService.state.desktopWidgets[identifier] = stateData;
        SettingsService.triggerSave();
    }

    function toggleEnabled() {
        enabled = !enabled;
        saveState();
    }

    Connections {
        target: SettingsService
        function onStateLoaded() {
            root.enabled = Utils.valueOrDefault(SettingsService.state.desktopWidgets[root.identifier]?.enabled, true);
            root.x = Utils.valueOrDefault(SettingsService.state.desktopWidgets[root.identifier]?.x, 0);
            root.y = Utils.valueOrDefault(SettingsService.state.desktopWidgets[root.identifier]?.y, 0);
        }
    }
}
