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
          name = "move_windows_to_monitor";
          runtimeInputs =
            []
            ++ lib.optionals hyprland.enable [
              prev.hyprland
            ];
          text = ''
            ${lib.optionalString hyprland.enable ''
              hyprctl dispatch "hl.dsp.workspace.move({workspace = 1, monitor = 1})"
              hyprctl dispatch "hl.dsp.workspace.move({workspace = 2, monitor = 1})"
              hyprctl dispatch "hl.dsp.workspace.move({workspace = 3, monitor = 1})"
              hyprctl dispatch "hl.dsp.workspace.move({workspace = 4, monitor = 1})"
              hyprctl dispatch "hl.dsp.workspace.move({workspace = 5, monitor = 1})"
              hyprctl dispatch "hl.dsp.workspace.move({workspace = 6, monitor = 1})"
              hyprctl dispatch "hl.dsp.workspace.move({workspace = 7, monitor = 1})"
              hyprctl dispatch "hl.dsp.workspace.move({workspace = 8, monitor = 1})"
              hyprctl dispatch "hl.dsp.workspace.move({workspace = 9, monitor = 1})"
              hyprctl dispatch "hl.dsp.workspace.move({workspace = 10, monitor = 1})"
              hyprctl dispatch "hl.dsp.workspace.move({workspace = 11, monitor = 0})"
              hyprctl dispatch "hl.dsp.focus({monitor = 0})"
              hyprctl dispatch "hl.dsp.focus({monitor = 0})"
            ''}
          '';
        };
      })
    ];
  };
}
