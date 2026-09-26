pragma Singleton

import Quickshell
import Quickshell.Services.Mpris as QSM

Singleton {
    readonly property list<QSM.MprisPlayer> players: QSM.Mpris.players.values.filter(p => !p.dbusName.includes("playerctld"))

    property QSM.MprisPlayer player: players[0] || null

    onPlayersChanged: () => {
        if (player == null) {
            if (players.length > 0) {
                player = players[0] || null;
            }
        }
    }

    readonly property bool available: player != null || false
    readonly property bool progressAvailable: player?.positionSupported && player?.lengthSupported && player?.canSeek || false

    readonly property string title: player?.trackTitle || ""
    readonly property string album: player?.trackAlbum || ""
    readonly property string artist: player?.trackArtist || ""
    readonly property string imageUrl: {
        // from https://github.com/caelestia-dots/shell/blob/aa836f2a29bf48b403c57af4bec224aed0412878/services/Players.qml#L25-L38 licenced GPL-3.0
        if (!player) {
            return "";
        }
        if (player.trackArtUrl) {
            return player.trackArtUrl;
        }
        const url = player.metadata["xesam:url"] || "";
        if (!url.startsWith("https://www.youtube.com/watch")) {
            return url;
        }
        const id = url.match(/[&?]v=([\w-]{11})/)?.[1];
        return id ? `https://img.youtube.com/vi/${id}/hqdefault.jpg` : "";
    }
    readonly property bool isPlaying: player?.isPlaying || false

    readonly property string playerIcon: {
        switch (player?.desktopEntry) {
        case "spotify":
            return "󰓇";
        default:
            return "󰐊";
        }
    }

    readonly property string formattedTime: formatMinutes(player?.position || 0) || ""
    readonly property string formattedRemainingTime: formatMinutes(player?.length - (player?.position || 0)) || ""

    // readonly property string timeLeftString:

    function setPlayer(p: QSM.MprisPlayer): void {
        player = p;
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

    function formatMinutes(seconds: real): string {
        const m = String(Math.floor(seconds / 60)).padStart(2, '0');
        const s = String(Math.floor(seconds % 60)).padStart(2, '0');

        return `${m}:${s}`;
    }
}
