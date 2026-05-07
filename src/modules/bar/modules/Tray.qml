import Quickshell.Services.SystemTray
import Quickshell.Widgets
import Quickshell
import QtQuick
import QtQuick.Layouts

Repeater {
    id: root
    model: SystemTray.items

    RowLayout {
        id: model
        required property SystemTrayItem modelData

        IconImage {
            implicitSize: 20
            source: model.trayIconSourceFor(model.modelData)

            MouseArea {
                anchors.fill: parent
                acceptedButtons: Qt.RightButton | Qt.LeftButton

                onClicked: evt => {
                    if (!model.modelData.onlyMenu && evt.button & Qt.LeftButton) {
                        model.primaryAction();
                        return;
                    }
                    if (model.modelData.hasMenu) {
                        model.openMenu(evt);
                    }
                }
            }
        }

        PopupWindow {
            id: popup
            anchor.window: parentWindow
        }

        function primaryAction() {
            modelData.activate();
        }

        function openMenu(evt) {
            const p = parent.mapToItem(popup.contentItem, evt.x, evt.y);

            modelData.display(popup, p.x, p.y);
        }

        // from <https://github.com/AvengeMedia/DankMaterialShell/blob/7c991bc4e3ca3a559b31ae76572eae96c25d2b57/quickshell/Modules/DankBar/Widgets/SystemTrayBar.qml#L47-L70>
        function trayIconSourceFor(trayItem: SystemTrayItem): string {
            let icon = trayItem && trayItem.icon;
            if (typeof icon === 'string' || icon instanceof String) {
                if (icon === "")
                    return "";
                if (icon.includes("?path=")) {
                    const split = icon.split("?path=");
                    if (split.length !== 2)
                        return icon;
                    const name = split[0];
                    const path = split[1];
                    let fileName = name.substring(name.lastIndexOf("/") + 1);
                    if (fileName.startsWith("dropboxstatus")) {
                        fileName = `hicolor/16x16/status/${fileName}`;
                    }
                    return `file://${path}/${fileName}`;
                }
                if (icon.startsWith("/") && !icon.startsWith("file://"))
                    return `file://${icon}`;
                return icon;
            }
            return "";
        }
    }
}
