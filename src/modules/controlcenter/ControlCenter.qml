pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts

import qs.widgets
import qs.config
import qs.modules.controlcenter.modules

ColumnLayout {
    spacing: Config.spacing
    CText {
        text: "Control Center"
        font.bold: true
    }

    Sliders {}

    NotificationCenter {
        Layout.fillWidth: true
    }

    NetworkCenter {
        Layout.fillWidth: true
    }
}
