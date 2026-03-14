{
  pkgs,
  lib,
  ...
}: let
  # Move all windows to monitor on connect (https://wiki.land/FAQ/#how-do-i-move-my-favorite-workspaces-to-a-new-monitor-when-i-plug-it-in)
  monitorConnectScript = pkgs.writeShellApplication {
    name = "move-workspaces-on-monitor-connect";
    runtimeInputs = with pkgs; [
      hyprland
      gawk # awk
    ];
    text = ''
        handle() {
        case $1 in monitoradded*)
          ${pkgs.move-windows-to-monitor}/bin/move-windows-to-monitor
        esac
      }

      socat - "UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/''\${HYPRLAND_INSTANCE_SIGNATURE}/.socket2.sock" | while read -r line; do handle "$line"; done
    '';
  };
in {
  wayland.windowManager.hyprland.settings = {
    "exec-once" = [
      "${pkgs.networkmanagerapplet}/bin/nm-applet" # Start networkmanager in systray
      "${lib.getExe monitorConnectScript}"
    ];
  };
}
