{...}: {
  flake.nixosModules.wm = {
    config,
    pkgs,
    lib,
    ...
  }: let
    hyprland = config.wayland.windowManager.hyprland;
  in {
    home-manager.users.dastarruer = lib.mkIf hyprland.enable {
      home.packages = [
        (pkgs.writeShellApplication {
          name = "move-windows-to-monitor";
          runtimeInputs = [pkgs.hyprland];
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
            hyprctl dispatch focusmonitor 0
            hyprctl dispatch focusworkspaceoncurrentmonitor 11
            hyprctl dispatch focusmonitor 1
          '';
        })
      ];
    };
  };
}
