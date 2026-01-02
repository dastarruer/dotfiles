{
  config,
  lib,
  ...
}: {
  options = {
    myPrograms.steam-link.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable Steam Link.";
    };
  };

  config = lib.mkIf config.myPrograms.steam-link.enable {
    services.flatpak = {
      packages = [
        "flathub:app/com.valvesoftware.SteamLink/x86_64/stable"
      ];
    };
  };
}
