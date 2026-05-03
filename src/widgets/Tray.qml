import Quickshell.Services.SystemTray
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts

Repeater {
    model: SystemTray.items

    RowLayout {
        id: model
        required property SystemTrayItem modelData

        IconImage {
            implicitSize: 20
            source: {
                console.log(model.modelData.title, model.modelData.icon);
                return model.modelData.icon;
            }

            MouseArea {
                anchors.fill: parent
                onClicked: evt => {
                    if (model.modelData.onlyMenu) {} else {
                        model.modelData.activate();
                    }
                }
            }
        }
    }
}
