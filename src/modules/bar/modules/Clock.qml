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

    BarPopup {
        id: popup
        barItem: root

        CalendarPopup {}
    }
}
