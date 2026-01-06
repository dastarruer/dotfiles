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
    home-manager.window-manager.hypr.enable = lib.mkOption {
      type = lib.types.bool;
      default = config.home-manager.window-manager.enable;
      description = "Enable hyprland, hypridle, hyprsunset, and hyprlock.";
    };
  };

  config = let
    cfg = config.home-manager.window-manager.hypr;
  in {
    home-manager.window-manager.hypr = {
      hyprland.enable = lib.mkDefault cfg.enable;
      hypridle.enable = lib.mkDefault cfg.enable;
      hyprlock.enable = lib.mkDefault cfg.enable;
      hyprsunset.enable = lib.mkDefault cfg.enable;
    };
  };
}
