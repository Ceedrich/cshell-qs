import QtQuick.Layouts

import qs.config

BarPill {
    RowLayout {
        spacing: Config.spacing
        Clock {}
        Workspaces {}
        Volume {}
        Battery {}
        Brightness {}
    }
}
