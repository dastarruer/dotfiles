{
  config,
  lib,
  ...
}: {
  options = {
    myPrograms.steam-link.enable = lib.mkEnableOption "Enable the Steam Link app for remoting into the Steam Deck.";
  };

  config = lib.mkIf config.myPrograms.steam-link.enable {
    services.flatpak = {
      packages = [
        "flathub:app/com.valvesoftware.SteamLink/x86_64/stable"
      ];
    };
  };
}
