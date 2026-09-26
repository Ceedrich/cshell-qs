pragma Singleton
import Quickshell
import QtQuick

Singleton {
    function select_from_list(ratio: real, list: var): var {
        const index = Math.min(Math.floor(ratio * list.length), list.length - 1);
        return list[index];
    }

    function clamp(low, high, value) {
        return Math.min(Math.max(value, low), high);
    }

    function formatTime(date: date): string {
        return Qt.formatTime(date, "hh:mm");
    }

    function formatDate(date: date): string {
        return Qt.formatDate(date, "dd.MM.yyyy");
    }

    function valueOrDefault(value, defaultValue) {
        if (value == null) {
            return defaultValue;
        } else {
            return value;
        }
    }

    function leftPad(str: string, len: int, c = ' '): string {
        if (str.length < len) {
            return (c.repeat(len - str.length)) + str;
        }
        return str;
    }
}
