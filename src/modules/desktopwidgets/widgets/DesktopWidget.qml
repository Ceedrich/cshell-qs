import QtQuick
import Quickshell.Widgets

import qs.services
import qs.utils

WrapperRectangle {
    id: root
    visible: enabled

    property string identifier: objectName

    color: "transparent"

    DragHandler {
        id: handler
        onActiveChanged: {
            if (!active) {
                root.setStateData({
                    x: root.x,
                    y: root.y
                });
                SettingsService.triggerSave();
            }
        }
    }

    function setStateData(data) {
        SettingsService.state.desktopWidgets[identifier] = data;
    }
    function setConfigData(data) {
        SettingsService.data.desktopWidgets[identifier] = data;
    }

    Connections {
        target: SettingsService
        function onLoaded() {
            root.enabled = Utils.valueOrDefault(SettingsService.data.desktopWidgets[root.identifier]?.enabled, true);
        }
        function onStateLoaded() {
            root.x = Utils.valueOrDefault(SettingsService.state.desktopWidgets[root.identifier]?.x, 0);
            root.y = Utils.valueOrDefault(SettingsService.state.desktopWidgets[root.identifier]?.y, 0);
        }
    }
}
