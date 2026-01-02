{
  config,
  lib,
  ...
}: {
  options = {
    dotfiles.steam-link.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable Steam Link.";
    };
  };

  config = lib.mkIf config.dotfiles.steam-link.enable {
    services.flatpak = {
      packages = [
        "flathub:app/com.valvesoftware.SteamLink/x86_64/stable"
      ];
    };
  };
}
