{pkgs, ...}: {
  wayland.windowManager.hyprland.settings = {
    "exec-once" = let
      name = "handle_monitor_connect";
    in [
      # Start networkmanager in systray
      "${pkgs.networkmanager}/bin/nm-applet"

      # Move all windows to monitor on connect (https://wiki.hypr.land/FAQ/#how-do-i-move-my-favorite-workspaces-to-a-new-monitor-when-i-plug-it-in)
      "${pkgs.writeShellApplication {
        name = "${name}";
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
      }}/bin/${name}"
    ];
  };
}
