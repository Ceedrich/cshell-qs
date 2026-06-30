import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts

import qs.config
import qs.services
import qs.utils
import qs.widgets

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
            ShellService.sendNotification("Timer", "Ahhhhhh, the timer is done");
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
            CText {
                Layout.fillWidth: true
                text: root.isStopwatch ? "Stopwatch" : "Timer"
                horizontalAlignment: Text.AlignHCenter
            }

            RowLayout {
                id: numberDisplay
                Layout.alignment: Qt.AlignHCenter
                spacing: 0
                property int fontSize: 60

                CTextButton {
                    enabled: root.isTimer
                    font.pixelSize: numberDisplay.fontSize
                    text: Utils.leftPad(`${root.displayMinutes}`, 2, "0")
                    rightClickEnabled: true
                    scrollingEnabled: true

                    rightPadding: 0
                    leftPadding: 0
                    bottomPadding: 0
                    topPadding: 0

                    onClicked: root.updateTargetSeconds(60)
                    onRightClicked: root.updateTargetSeconds(-60)
                    onScrollY: delta => root.updateTargetSeconds(delta * 60)
                }
                CText {
                    font.pixelSize: numberDisplay.fontSize
                    text: ":"
                }
                CTextButton {
                    enabled: root.isTimer
                    font.pixelSize: numberDisplay.fontSize
                    text: Utils.leftPad(`${root.displaySeconds}`, 2, "0")
                    rightClickEnabled: true
                    scrollingEnabled: true

                    rightPadding: 0
                    leftPadding: 0
                    bottomPadding: 0
                    topPadding: 0

                    onClicked: root.updateTargetSeconds(1)
                    onRightClicked: root.updateTargetSeconds(-1)
                    onScrollY: delta => root.updateTargetSeconds(delta)
                }
                CText {
                    font.pixelSize: numberDisplay.fontSize
                    text: ":"
                }
                CText {
                    font.pixelSize: numberDisplay.fontSize
                    text: Utils.leftPad(`${root.displayCents}`, 2, "0")
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

    function updateTargetSeconds(delta) {
        persistent.targetTimeSeconds = Utils.clamp(1, 99 * 60 + 59, persistent.targetTimeSeconds + delta);
    }
}
