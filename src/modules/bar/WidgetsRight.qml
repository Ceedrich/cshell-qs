import QtQuick
import QtQuick.Layouts

import qs.modules.bar.modules
import qs.config

RowLayout {
    id: root
    required property QtObject barWindow

    BarPill {
        RowLayout {
            spacing: Config.spacing
            IdleInhibitor {
                barWindow: root.barWindow
            }
            Tray {
                barWindow: root.barWindow
            }
        }
    }

    BarPill {
        RowLayout {
            ControlCenterToggle {
                barWindow: root.barWindow
            }
        }
    }
}
