{
  config,
  lib,
  ...
}: {
  options = {
    home-manager.window-manager.hypr.hyprsunset.enable = lib.mkEnableOption "Enable hyprsunset.";
  };

  config = lib.mkIf config.home-manager.window-manager.hypr.hyprsunset.enable {
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
