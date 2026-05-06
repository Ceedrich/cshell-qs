import QtQuick
import Quickshell

import qs.widgets

CText {
    id: root
    required property PopupWindow controlPanelWindow

    text: "󰍜"
    onClicked: () => root.controlPanelWindow.visible = !root.controlPanelWindow.visible
}
