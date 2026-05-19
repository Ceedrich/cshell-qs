pragma Singleton
import Quickshell.Hyprland

import Quickshell

import qs.utils

Singleton {
    function isActive(ws: HyprlandWorkspace): bool {
        return ws.id === Hyprland.focusedWorkspace?.id;
    }

    function focus(ws: HyprlandWorkspace): void {
        if (ws == null) {
            return;
        }
        if (Hyprland.usingLua) {
            Hyprland.dispatch(`hl.dsp.focus({workspace = "${ws.id}"})`);
        } else {
            Hyprland.dispatch(`workspace ${ws.id}`);
        }
    }

    function moveWindowToWorkspace(ws: HyprlandWorkspace, windowAdress: string): void {
        if (ws == null) {
            return;
        }
        if (Hyprland.usingLua) {
            // TODO: add lua implementation
        } else {
            const text = `movetoworkspacesilent ${ws.id}` + (windowAdress ? `,address:0x${windowAdress}` : "");
            Hyprland.dispatch(text);
        }
    }

    function prev() {
        let idx = Hyprland.workspaces.indexOf(Hyprland.focusedWorkspace);
        idx = Utils.clamp(0, Hyprland.workspaces.values.length - 1, idx - 1);
        let new_ws = Hyprland.workspaces.values[idx];
        focus(new_ws);
    }
    function next() {
        let idx = Hyprland.workspaces.indexOf(Hyprland.focusedWorkspace);
        idx = Utils.clamp(0, Hyprland.workspaces.values.length - 1, idx + 1);
        let new_ws = Hyprland.workspaces.values[idx];
        focus(new_ws);
    }
}
