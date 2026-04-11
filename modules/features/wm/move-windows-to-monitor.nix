{...}: {
  flake.nixosModules.wm = {
    config,
    lib,
    ...
  }: let
    # Check the nixos level option instead of the hm one to preven infinite recursion
    hyprland = config.programs.hyprland;
  in {
    nixpkgs.overlays = lib.mkIf hyprland.enable [
      (final: prev: {
        move-windows-to-monitor = prev.writeShellApplication {
          name = "move-windows-to-monitor";
          runtimeInputs =
            []
            ++ lib.optionals hyprland.enable [
              prev.hyprland
            ];
          text = ''
            ${lib.optionalString hyprland.enable ''
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
            ''}
          '';
        };
      })
    ];
  };
}
