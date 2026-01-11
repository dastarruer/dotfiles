{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    home-manager.desktop.whatsapp.enable = lib.mkOption {
      type = lib.types.bool;
      default = config.home-manager.desktop.enable;
      description = "Enable WhatsApp PWA.";
    };
  };

  config = lib.mkIf config.home-manager.desktop.whatsapp.enable {
    programs.firefoxpwa = {
      enable = true;

      # Note that each PWA needs a different profile with a unique ULID
      # Run `nix-shell -p ulid --run "ulid"` to get a valid ULID
      profiles."01KEN5TVZ2F2HDMJCZ9X9X4G1C".sites."01KEN5RZRFFRJSBATWYF2ZVJKH" = {
        name = "WhatsApp";
        url = "https://web.whatsapp.com/";
        manifestUrl = "https://web.whatsapp.com/manifest.json";

        desktopEntry = {
          enable = true;
          icon = pkgs.fetchurl {
            url = "https://web.whatsapp.com/img/favicon/1x/favicon.png";
            sha256 = "sha256-0MrfJA6JNAuT3zUkDngJA5wcV0vgX74s8yQ+L0h7yew=";
          };
        };
      };
    };
  };
}
