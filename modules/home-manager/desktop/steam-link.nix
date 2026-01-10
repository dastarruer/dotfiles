{
  config,
  lib,
  ...
}: {
  options = {
    home-manager.desktop.steam-link.enable = lib.mkOption {
      type = lib.types.bool;
      default = config.home-manager.desktop.enable;
      description = "Enable Steam Link.";
    };
  };

  config = lib.mkIf config.home-manager.desktop.steam-link.enable {
    services.flatpak = {
      packages = [
        "flathub:app/com.valvesoftware.SteamLink/x86_64/stable"
      ];
    };
  };
}
