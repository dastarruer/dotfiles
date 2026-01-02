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
    dotfiles.hypr.enable = lib.mkOption {
      type = lib.types.bool;
      default = config.dotfiles.window-manager.enable;
      description = "Enable hyprland, hypridle, hyprsunset, and hyprlock.";
    };
  };

  config = let
    cfg = config.dotfiles.hypr;
  in {
    dotfiles.hypr = {
      hyprland.enable = lib.mkDefault cfg.enable;
      hypridle.enable = lib.mkDefault cfg.enable;
      hyprlock.enable = lib.mkDefault cfg.enable;
      hyprsunset.enable = lib.mkDefault cfg.enable;
    };
  };
}
