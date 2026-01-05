{
  config,
  lib,
  ...
}: {
  options = {
    dotfiles.window-manager.hypr.hyprsunset.enable = lib.mkEnableOption "Enable hyprsunset.";
  };

  config = lib.mkIf config.dotfiles.window-manager.hypr.hyprsunset.enable {
    services.hyprsunset = {
      enable = true;

      extraArgs = [
        # Change temperature to a slightly warmer 5500K
        "-t"
        "5500"
      ];
    };
  };
}
