{pkgs, ...}: {
  wayland.windowManager.hyprland.settings = {
    bind = let
      name = "move_windows_to_monitor";
    in [
      "SUPER, K, exec, ${pkgs.writeShellApplication {
        name = "${name}";
        runtimeInputs = with pkgs; [
          hyprland
        ];
        text = ''
          hyprctl dispatch moveworkspacetomonitor "1 1"
          hyprctl dispatch moveworkspacetomonitor "2 1"
          hyprctl dispatch moveworkspacetomonitor "3 1"
          hyprctl dispatch moveworkspacetomonitor "4 1"
          hyprctl dispatch moveworkspacetomonitor "5 1"
          hyprctl dispatch moveworkspacetomonitor "6 1"
          hyprctl dispatch moveworkspacetomonitor "7 1"
          hyprctl dispatch moveworkspacetomonitor "8 1"
          hyprctl dispatch moveworkspacetomonitor "9 1"
          hyprctl dispatch moveworkspacetomonitor "10 1"
          hyprctl dispatch moveworkspacetomonitor "11 0"

          # Change focused workspace on monitor 0 to 11
          hyprctl dispatch focusmonitor 0
          hyprctl dispatch focusworkspaceoncurrentmonitor 11
          hyprctl dispatch focusmonitor 1
        '';
      }}/bin/${name}"
    ];
  };
}
