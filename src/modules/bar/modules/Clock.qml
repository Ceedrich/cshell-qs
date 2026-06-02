import QtQuick

import qs.services
import qs.config
import qs.widgets

CBarItem {
    id: root
    required property QtObject barWindow

    text: TimeService.time
    textColor: Colors.overlay1
    onClicked: popup.toggle()

    BarPopup {
        id: popup
        barItem: root

        CCalendar {}
    }
}
