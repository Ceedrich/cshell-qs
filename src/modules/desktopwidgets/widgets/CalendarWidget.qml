import QtQuick
import Quickshell.Widgets

import qs.widgets
import qs.config

DesktopWidget {
    implicitWidth: wrapper.implicitWidth
    implicitHeight: wrapper.implicitHeight

    WrapperRectangle {
        id: wrapper
        color: Colors.base
        margin: Config.spacing

        radius: Config.border.radius
        border.color: Colors.overlay2
        border.width: Config.border.width

        CCalendar {
            id: cal
        }
    }
}
