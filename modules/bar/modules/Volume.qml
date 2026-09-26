import QtQuick

import qs.config
import qs.services
import qs.utils
import qs.widgets

CBarItem {
    id: root
    enabled: VolumeService.ready

    textColor: VolumeService.muted ? Colors.overlay1 : defaultColor
    underline: !VolumeService.muted

    text: `${Math.round((VolumeService.volume || 0) * 100)}% ${VolumeService.volumeIcon}`

    scrollingEnabled: true

    onClicked: VolumeService.toggleMuted()
    onScrollY: delta => VolumeService.incrementVolume(delta / 100)
}
