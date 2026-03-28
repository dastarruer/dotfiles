{
  config,
  lib,
  ...
}: let
  cfg = config.home-manager.desktop.gaming.steam;
  ludusavi = config.home-manager.desktop.gaming.ludusavi;
in {
  imports = [
    ./games
  ];

  options = {
    home-manager.desktop.gaming.steam.enable = lib.mkOption {
      type = lib.types.bool;
      default = config.home-manager.desktop.gaming.enable;
      description = "Enable steam.";
    };
  };

  config = lib.mkIf cfg.enable {
    # This is installed w nixos instead
    # home.packages = [
    #   pkgs.steam
    # ];

    # Using this flake: https://github.com/different-name/steam-config-nix we can add settings for specific games
    programs.steam.config = {
      enable = true;
      closeSteam = true;
      defaultCompatTool = "GE-Proton";
    };

    services.ludusavi.settings.roots = lib.mkIf ludusavi.enable [
      {
        path = "~/.local/share/Steam";
        store = "steam";
      }
    ];
  };
}
