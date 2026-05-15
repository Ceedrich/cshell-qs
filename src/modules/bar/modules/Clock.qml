import QtQuick

import qs.services
import qs.config
import qs.widgets

CText {
    id: root
    required property QtObject barWindow

    text: Time.time
    color: Colors.overlay1

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: () => popup.visible = !popup.visible
    }

    BarPopup {
        id: popup
        barItem: root

        CalendarPopup {}
    }
}
