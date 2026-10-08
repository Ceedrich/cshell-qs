import QtQuick.Layouts
import QtQuick

import qs.Components
import qs.config
import qs.services
import qs.modules.bar.modules

Container {
    id: root
    required property QtObject barWindow

    leftMargin: 16
    rightMargin: 16
    topMargin: 8
    bottomMargin: 8

    defaultItem: RowLayout {
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

    Binding {
        target: ShellService
        property: "mainBarContainer"
        value: root
    }
}
