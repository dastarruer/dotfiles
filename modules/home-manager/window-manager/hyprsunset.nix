{
  config,
  lib,
  ...
}: {
  options = {
    home-manager.window-manager.hyprsunset.enable = lib.mkOption {
      type = lib.types.bool;
      default = config.home-manager.window-manager.enable;
      description = "Enable hyprsunset.";
    };
  };

  config = lib.mkIf config.home-manager.window-manager.hyprsunset.enable {
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
