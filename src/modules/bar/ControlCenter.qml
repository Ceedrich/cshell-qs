import Quickshell.Widgets
import QtQuick.Layouts
import QtQuick

import qs.widgets
import qs.config

WrapperRectangle {
    margin: Config.spacing
    color: Colors.base
    border.width: Config.border.width
    border.color: Colors.overlay0
    radius: Config.border.radius

    ColumnLayout {
        RowLayout {
            CText {
                text: "Control Center"
            }

            Item {
                Layout.fillWidth: true
            }

            CText {
                text: "xx"
            }
        }
    }
}
