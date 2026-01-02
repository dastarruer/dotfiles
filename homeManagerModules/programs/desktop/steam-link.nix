{
  config,
  lib,
  ...
}: {
  options = {
    dotfiles.desktop.steam-link.enable = lib.mkOption {
      type = lib.types.bool;
      default = config.dotfiles.desktop.enableAll;
      description = "Enable Steam Link.";
    };
  };

  config = lib.mkIf config.dotfiles.desktop.steam-link.enable {
    services.flatpak = {
      packages = [
        "flathub:app/com.valvesoftware.SteamLink/x86_64/stable"
      ];
    };
  };
}
