{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    home-manager.desktop.streaming.enable = lib.mkOption {
      type = lib.types.bool;
      default = config.home-manager.desktop.enable;
      description = "Enable a completely and definitely legal PWA for streaming TV shows and movies.";
    };
  };

  config = lib.mkIf config.home-manager.desktop.streaming.enable {
    programs.firefoxpwa = {
      enable = true;

      # Note that each PWA needs a different profile with a unique ULID
      # Run `nix-shell -p ulid --run "ulid"` to get a valid ULID
      profiles."01KEN9HA9QJFR8NDDJFE502G75".sites."01KEN9HF2RDAYAGHADS0YV8KFE" = {
        name = "TV Shows & Movies";
        url = "https://ww3.soap2dayhdz.com";
        manifestUrl = "https://ww3.soap2dayhdz.com/manifest.json";

        desktopEntry = {
          enable = true;
          icon = pkgs.fetchurl {
            url = "https://ww3.soap2dayhdz.com/icon/apple-touch-icon.png";
            sha256 = "sha256-SuWHoefl2b03VPtPu6AjgmN9VhnhUXZvFO43PIO96zw=";
          };
        };
      };
    };
  };
}
