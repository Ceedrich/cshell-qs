import QtQuick.Layouts

import qs.config

BarPill {
    RowLayout {
        spacing: Config.spacing
        Clock {}
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
    }
}
