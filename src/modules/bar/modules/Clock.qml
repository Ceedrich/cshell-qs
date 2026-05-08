import QtQuick
import Quickshell

import qs.services
import qs.config
import qs.widgets

CText {
    id: root
    required property QtObject barWindow

    text: Time.time
    color: Colors.overlay1

    onClicked: () => popup.visible = !popup.visible

    PopupWindow {
        id: popup
        anchor.item: root
        anchor.rect.y: root.barWindow.height
        anchor.rect.x: root.width / 2 - width / 2

        grabFocus: true

        implicitWidth: cal.implicitWidth
        implicitHeight: cal.implicitHeight

        visible: true

        color: "transparent"

        CalendarPopup {
            id: cal
        }
    }
}
