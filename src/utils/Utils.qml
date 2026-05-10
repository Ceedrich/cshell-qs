pragma Singleton
import Quickshell

Singleton {
    function select_from_list(ratio: real, list: var): var {
        const index = Math.min(Math.floor(ratio * list.length), list.length - 1);
        return list[index];
    }

    function clamp(low, high, value) {
        return Math.min(Math.max(value, low), high);
    }
}
