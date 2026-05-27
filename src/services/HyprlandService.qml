pragma Singleton
import Quickshell
import Quickshell.Hyprland

import qs.utils

Singleton {
    readonly property var workspaces: [...(Hyprland.workspaces?.values || [])].sort((a, b) => a.id - b.id) || []

    function isActiveWorkspace(wsId: string): bool {
        return (`${wsId}` === `${Hyprland.focusedWorkspace?.id}`);
    }

    function focusWorkspace(wsId: string): void {
        if (Hyprland.usingLua) {
            Hyprland.dispatch(`hl.dsp.focus({ workspace = "${wsId}" })`);
        } else {
            Hyprland.dispatch(`workspace ${wsId}`);
        }
    }

    function focusWindow(address: string): void {
        if (Hyprland.usingLua) {} else {
            Hyprland.dispatch(`focuswindow address:${address}`);
        }
    }

    /// Omit windowAddress to use current workspace
    function moveWindowToWorkspace(wsId: string, windowAddress: string): void {
        if (Hyprland.usingLua) {
            // TODO: lua?
            // Hyprland.dispatch(`hl.dsp.window.move({ workspace = "${wsId}", follow = false })`);
        } else {
            Hyprland.dispatch(`movetoworkspacesilent ${wsId}` + (windowAddress ? `,address:0x${windowAddress}` : ""));
        }
    }

    function focusNewWorkspace(): void {
        focusWorkspace("emptyn");
    }

    function moveWindowToNewWorkspace(windowAddress: string): void {
        moveWindowToWorkspace("emptyn", windowAddress);
    }

    function focusPreviousWorkspace(): void {
        let idx = Hyprland.workspaces.indexOf(Hyprland.focusedWorkspace);
        idx = Utils.clamp(0, Hyprland.workspaces.values.length - 1, idx - 1);
        let new_ws = Hyprland.workspaces.values[idx];
        focusWorkspace(new_ws.id);
    }
    function focusNextWorkspace(): void {
        let idx = Hyprland.workspaces.indexOf(Hyprland.focusedWorkspace);
        idx = Utils.clamp(0, Hyprland.workspaces.values.length - 1, idx + 1);
        let new_ws = Hyprland.workspaces.values[idx];
        focusWorkspace(new_ws.id);
    }
}
