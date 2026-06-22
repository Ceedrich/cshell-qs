pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property bool isLoaded: false

    readonly property alias data: adapter
    readonly property string configPath: (Quickshell.env("XDG_CONFIG_HOME") || Quickshell.env("HOME") + "/.config") + "/cshell/"

    FileView {
        id: settingsFile
        path: root.configPath + "config.json"
        watchChanges: true
        onFileChanged: reload()
        onAdapterUpdated: writeAdapter()

        onLoaded: {
            root.isLoaded = true;
        }

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

    Timer {
        id: saveTimer
        interval: 500
        onTriggered: {
            if (root.isLoaded) {
                settingsFile.writeAdapter();
            } else {
                // try saving again if the file is not yet loaded
                restart();
            }
        }
    }

    function triggerSave() {
        saveTimer.restart();
    }

    Component.onCompleted: {
        Quickshell.execDetached(["mkdir", "-p", configPath]);
    }
}
