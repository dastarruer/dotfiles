{
  config,
  lib,
  ...
}: {
  imports = [
    ./hyprland
    ./hypridle.nix
    ./hyprlock
    ./hyprsunset.nix
  ];

  options = {
    dotfiles.window-manager.hypr.enable = lib.mkOption {
      type = lib.types.bool;
      default = config.dotfiles.window-manager.enable;
      description = "Enable hyprland, hypridle, hyprsunset, and hyprlock.";
    };
  };

  config = let
    cfg = config.dotfiles.window-manager.hypr;
  in {
    dotfiles.window-manager.hypr = {
      hyprland.enable = lib.mkDefault cfg.enable;
      hypridle.enable = lib.mkDefault cfg.enable;
      hyprlock.enable = lib.mkDefault cfg.enable;
      hyprsunset.enable = lib.mkDefault cfg.enable;
    };
  };
}
