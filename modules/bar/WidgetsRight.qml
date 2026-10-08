import QtQuick
import QtQuick.Layouts

import qs.modules.bar.modules
import qs.config
import qs.Components

RowLayout {
    id: root
    required property QtObject barWindow

    Container {
        defaultItem: RowLayout {
            spacing: Config.spacing
            IdleInhibitor {
                barWindow: root.barWindow
            }
            Tray {
                barWindow: root.barWindow
            }
        }
    }

    Container {
        defaultItem: RowLayout {
            ControlCenterToggle {
                barWindow: root.barWindow
            }
        }
    }
}
