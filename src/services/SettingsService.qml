pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    readonly property alias data: adapter
    readonly property string configPath: (Quickshell.env("XDG_CONFIG_HOME") || Quickshell.env("HOME") + "/.config") + "/cshell/"

    FileView {
        id: settingsFile
        path: root.configPath + "config.json"
        watchChanges: true
        onFileChanged: reload()
        onAdapterUpdated: writeAdapter()

        onLoadFailed: error => {
            if (error === FileViewError.FileNotFound) {
                writeAdapter();
            }
        }

        adapter: JsonAdapter {
            id: adapter
            property bool invertScrolling: false
        }
    }

    Component.onCompleted: {
        Quickshell.execDetached(["mkdir", "-p", configPath]);
    }
}
