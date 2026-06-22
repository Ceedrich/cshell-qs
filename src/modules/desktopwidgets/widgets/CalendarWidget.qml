import QtQuick

import qs.widgets
import qs.config

DesktopWidget {
    color: Colors.base
    margin: Config.spacing

    radius: Config.border.radius
    border.color: Colors.overlay2
    border.width: Config.border.width
    Item {
        implicitWidth: cal.implicitWidth
        implicitHeight: cal.implicitHeight

        CCalendar {
            id: cal
            anchors.fill: parent
        }
    }
}
