import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts

import qs.widgets
import qs.config
import qs.utils

DesktopWidget {
    id: root
    implicitWidth: content.implicitWidth
    implicitHeight: content.implicitHeight

    PersistentProperties {
        id: persistent
        reloadableId: root.identifier

        property bool isStopwatch: true

        property bool running: false

        property int targetTimeSeconds: 10

        property int elapsedMsBuffer: 0
        property int elapsedMs: 0

        onTargetTimeSecondsChanged: {
            // make sure elapsedMsBuffer is updated
            if (targetTimeSeconds <= 0) {
                targetTimeSeconds = 1;
            }
            if (running) {
                root.stop();
                root.start();
            }
        }
    }

    readonly property bool isStopwatch: persistent.isStopwatch
    readonly property bool isTimer: !persistent.isStopwatch

    readonly property int remainingMs: persistent.targetTimeSeconds * 1000 - persistent.elapsedMs

    readonly property int elapsedMinutes: Math.floor(persistent.elapsedMs / 1000 / 60)
    readonly property int elapsedSeconds: Math.floor(persistent.elapsedMs / 1000) % 60
    readonly property int elapsedCents: Math.floor((persistent.elapsedMs % 1000) / 10)

    readonly property int remainingMinutes: Math.floor(remainingMs / 1000 / 60)
    readonly property int remainingSeconds: Math.floor(remainingMs / 1000) % 60
    readonly property int remainingCents: Math.floor(remainingMs % 1000 / 10)

    readonly property int displayMinutes: persistent.isStopwatch ? elapsedMinutes : remainingMinutes
    readonly property int displaySeconds: persistent.isStopwatch ? elapsedSeconds : remainingSeconds
    readonly property int displayCents: persistent.isStopwatch ? elapsedCents : remainingCents

    ElapsedTimer {
        id: elapsedTimer
    }

    Timer {
        id: pollTimer
        interval: 10
        repeat: true
        onTriggered: {
            persistent.elapsedMs = persistent.elapsedMsBuffer + elapsedTimer.elapsedMs();
        }
    }

    Timer {
        id: timer
        interval: persistent.targetTimeSeconds * 1000
        running: false
        onTriggered: {
            root.reset();
            Quickshell.execDetached(["notify-send", "CShell", "Timer Finito"]);
        }
    }

    WrapperRectangle {
        id: content

        color: Colors.base
        margin: Config.spacing
        border.width: Config.border.width
        border.color: Colors.overlay2
        radius: Config.border.radius

        ColumnLayout {
            spacing: -8

            CText {
                Layout.fillWidth: true
                text: root.isStopwatch ? "Stopwatch" : "Timer"
                horizontalAlignment: Text.AlignHCenter
            }

            CText {
                id: numberDisplay
                Layout.alignment: Qt.AlignHCenter
                font.pixelSize: 60
                text: Utils.leftPad(`${root.displayMinutes}`, 2, "0") //
                + ":" + Utils.leftPad(`${root.displaySeconds}`, 2, "0") //
                + ":" + Utils.leftPad(`${root.displayCents}`, 2, "0")

                MouseArea {
                    anchors.fill: parent

                    acceptedButtons: Qt.RightButton | Qt.LeftButton

                    cursorShape: Qt.PointingHandCursor

                    enabled: root.isTimer
                    onWheel: evt => {
                        const delta = evt.angleDelta.y * Config.scrollFactor;
                        persistent.targetTimeSeconds = Utils.clamp(0, Infinity, persistent.targetTimeSeconds + delta);
                    }

                    onClicked: evt => {
                        if (evt.button === Qt.LeftButton) {
                            persistent.targetTimeSeconds = Utils.clamp(0, Infinity, persistent.targetTimeSeconds + 1);
                        }
                        if (evt.button === Qt.RightButton) {
                            persistent.targetTimeSeconds = Utils.clamp(0, Infinity, persistent.targetTimeSeconds - 1);
                        }
                    }
                }
            }

            RowLayout {
                Layout.alignment: Qt.AlignHCenter

                CTextButton {
                    font.pixelSize: 24
                    text: persistent.running ? "󰏤" : "󰐊"
                    onClicked: persistent.running ? root.stop() : root.start()
                }

                CTextButton {
                    font.pixelSize: 24
                    text: "󰜉"
                    onClicked: root.reset()
                }

                CTextButton {
                    text: "󱎫"
                    onClicked: root.toggleMode()
                }
            }
        }
    }

    function reset() {
        stop();
        persistent.elapsedMsBuffer = 0;
        persistent.elapsedMs = 0;
    }

    function stop() {
        persistent.running = false;
        pollTimer.stop();
        timer.stop();
        persistent.elapsedMsBuffer = persistent.elapsedMs;
        // timer.stop()
    }

    function start() {
        persistent.running = true;
        pollTimer.restart();
        elapsedTimer.restart();
        if (isTimer) {
            timer.interval = Math.max(persistent.targetTimeSeconds * 1000 - persistent.elapsedMsBuffer, 1);
            timer.restart();
        }
    }

    function toggleMode() {
        reset();
        persistent.isStopwatch = !persistent.isStopwatch;
    }
}
