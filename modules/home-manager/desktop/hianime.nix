{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    home-manager.desktop.hianime.enable = lib.mkOption {
      type = lib.types.bool;
      default = config.home-manager.desktop.enable;
      description = "Enable hianime PWA.";
    };
  };

  config = lib.mkIf config.home-manager.desktop.hianime.enable {
    programs.firefoxpwa = {
      enable = true;

      # Note that each PWA needs a different profile with a unique ULID
      # Run `nix-shell -p ulid --run "ulid"` to get a valid ULID
      profiles."01KEN6AHN9T22VYKX9RERBHBKN".sites."01KEN6APJP25MQKMWJCPP5XHBJ" = {
        name = "HiAnime";
        url = "https://hianime.to/";
        manifestUrl = "https://hianime.to/manifest.json";

        desktopEntry = {
          enable = true;
          icon = pkgs.fetchurl {
            url = "https://hianime.to/favicon.ico";
            sha256 = "sha256-T+TtCGQdoah+4ciB8ChZEvQGhMfngvscpHkjVT7+EFY=";
          };
        };
      };
    };
  };
}
