import QtQuick.Layouts
import QtQuick

import qs.config
import qs.modules.bar.modules

BarPill {
    id: root
    required property QtObject barWindow

    RowLayout {
        spacing: Config.spacing
        Clock {
            barWindow: root.barWindow
        }
        Workspaces {}
        Volume {
            defaultColor: Colors.blue
        }
        Battery {
            defaultColor: Colors.mauve
        }
        Brightness {
            defaultColor: Colors.blue
        }
        Bluetooth {
            defaultColor: Colors.mauve
        }
    }
}
