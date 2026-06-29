import QtQuick

import qs.config
import qs.services
import qs.utils
import qs.widgets

CBarItem {
    id: root
    property list<string> icons: ["󰕿", "󰖀", "󰕾"]
    property string icon_muted: "󰝟"

    enabled: VolumeService.ready

    property string icon: {
        if (!VolumeService.ready) {
            return "";
        }

        if (VolumeService.muted) {
            return icon_muted;
        }
        const icon = Utils.select_from_list(VolumeService.volume, icons);
        return icon;
    }
    textColor: VolumeService.muted ? Colors.overlay1 : defaultColor
    underline: !VolumeService.muted

    text: `${Math.round((VolumeService.volume || 0) * 100)}% ${icon}`

    scrollingEnabled: true

    onClicked: VolumeService.toggleMuted()
    onScrollY: delta => VolumeService.incrementVolume(delta / 100)
}
