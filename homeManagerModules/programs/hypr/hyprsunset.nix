{
  config,
  lib,
  ...
}: {
  options = {
    dotfiles.hypr.hyprsunset.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable hyprsunset.";
    };
  };

  config = lib.mkIf config.dotfiles.hypr.hyprsunset.enable {
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
