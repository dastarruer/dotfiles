{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.home-manager.window-manager.noctalia;
in {
  options = {
    home-manager.window-manager.noctalia.enable = lib.mkOption {
      type = lib.types.bool;
      default = config.home-manager.window-manager.enable;
      description = "Enable noctalia.";
    };
  };

  config = lib.mkIf cfg.enable {
    nix.settings = {
      extra-substituters = ["https://noctalia.cachix.org"];
      extra-trusted-public-keys = ["noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="];
    };

    programs.noctalia-shell = {
      enable = true;
    };
  };
}
