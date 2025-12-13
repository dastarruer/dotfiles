{pkgs, ...}: {
  wayland.windowManager.hyprland.settings = {
    "exec-once" = let
      name = "handle_monitor_connect";
    in [
      # Start networkmanager in systray
      "${pkgs.networkmanager}/bin/nm-applet"

      # Move all windows to monitor on connect (https://wiki.hypr.land/FAQ/#how-do-i-move-my-favorite-workspaces-to-a-new-monitor-when-i-plug-it-in)
      # TODO: make this actually work
      "${pkgs.writeShellApplication {
        name = "${name}";
        runtimeInputs = with pkgs; [
          hyprland
          gawk # awk package
        ];
        text = ''
            handle() {
            case $1 in monitoradded*)
                # TODO: this doesnt point to the correct path
              ./move_windows_to_monitor.sh
            esac
          }

          socat - "UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/''\${HYPRLAND_INSTANCE_SIGNATURE}/.socket2.sock" | while read -r line; do handle "$line"; done
        '';
      }}/bin/${name}"
    ];
  };
}
