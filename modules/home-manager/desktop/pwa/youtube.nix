{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    home-manager.desktop.pwa.youtube.enable = lib.mkOption {
      type = lib.types.bool;
      default = config.home-manager.desktop.pwa.enable;
      description = "Enable YouTube PWA.";
    };
  };

  config = lib.mkIf config.home-manager.desktop.pwa.youtube.enable {
    programs.firefoxpwa = {
      enable = true;

      # Note that each PWA needs a different profile with a unique ULID
      # Run `nix-shell -p ulid --run "ulid"` to get a valid ULID
      profiles."01KENA2DTXQ4F14THNXPK3FQHF".sites."01KENA2HMJQK0WS9P1BCCSYKJ7" = {
        name = "YouTube";
        url = "https://www.youtube.com/";
        manifestUrl = "https://www.youtube.com/manifest.webmanifest";

        desktopEntry = {
          enable = true;
          icon = pkgs.fetchurl {
            url = "https://www.gstatic.com/youtube/img/branding/favicon/favicon_144x144_v2.png";
            sha256 = "sha256-i7VLHY/Ww2yWgrrkDBuMGvNa+0tB6aMuQgLSTvCXp6g=";
          };
        };
      };
    };
  };
}
