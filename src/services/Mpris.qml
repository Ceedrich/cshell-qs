pragma Singleton

import Quickshell
import Quickshell.Services.Mpris as QSM

Singleton {
    property QSM.MprisPlayer player: QSM.Mpris.players.values[0] || null

    readonly property bool available: player != null || false
    readonly property bool progressAvailable: player?.positionSupported && player?.lengthSupported && player?.canSeek || false

    readonly property string title: player?.trackTitle || ""
    readonly property string album: player?.trackAlbum || ""
    readonly property string artist: player?.trackArtist || ""
    readonly property string trackArtUrl: player?.trackArtUrl || ""
    readonly property bool isPlaying: player?.isPlaying || false

    readonly property string playerIcon: {
        switch (player?.desktopEntry) {
        case "spotify":
            return "󰓇";
        default:
            return "󰐊";
        }
    }

    function togglePlaying(): void {
        player.togglePlaying();
    }

    function previous(): void {
        player.previous();
    }

    function next(): void {
        player.next();
    }

    function raise(): void {
        player.raise();
    }
}
