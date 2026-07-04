pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property bool isLoaded: false
    readonly property alias data: settingsAdapter
    readonly property alias state: stateAdapter

    readonly property string configPath: (Quickshell.env("XDG_CONFIG_HOME") || Quickshell.env("HOME") + "/.config") + "/cshell/"
    readonly property string stateDir: (Quickshell.env("XDG_CONFIG_HOME") || Quickshell.env("HOME") + "/.local/state") + "/cshell/"
    readonly property string settingsFilePath: configPath + "settings.json"
    readonly property string stateFilePath: stateDir + "state.json"

    signal loaded
    signal stateLoaded

    Timer {
        id: stateSaveTimer
        interval: 500
        onTriggered: {
            if (root.isLoaded) {
                stateFileView.writeAdapter();
            } else {
                // try saving again if the file is not yet loaded
                restart();
            }
        }
    }

    Timer {
        id: settingsSaveTimer
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

    FileView {
        id: settingsFile
        path: root.settingsFilePath
        watchChanges: true
        onFileChanged: reload()

        onLoaded: {
            root.isLoaded = true;
            root.loaded();
        }

        onLoadFailed: error => {
            if (error === FileViewError.FileNotFound) {
                writeAdapter();
            }
        }

        adapter: JsonAdapter {
            id: settingsAdapter
            property bool invertScrolling: false
            property real scrollFactor: 1
            property var desktopWidgets: ({})
        }
    }

    FileView {
        id: stateFileView
        path: root.stateFilePath
        watchChanges: false
        onAdapterUpdated: writeAdapter()

        onLoaded: {
            root.stateLoaded();
        }

        onLoadFailed: error => {
            if (error === FileViewError.FileNotFound) {
                writeAdapter();
            }
        }

        adapter: JsonAdapter {
            id: stateAdapter
            property var desktopWidgets: ({})
        }
    }

    function triggerSettingsSave() {
        settingsSaveTimer.restart();
    }

    function triggerStateSave() {
        stateSaveTimer.restart();
    }

    Component.onCompleted: {
        Quickshell.execDetached(["mkdir", "-p", configPath]);
        Quickshell.execDetached(["mkdir", "-p", stateDir]);
    }
}
