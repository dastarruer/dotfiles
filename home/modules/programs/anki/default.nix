# Check here for packaging an anki addon: https://github.com/NixOS/nixpkgs/blob/master/pkgs/games/anki/with-addons.nix
{config, ...}: {
  imports = [
    ./addons
  ];

  sops.secrets.anki_synckey = {};

  programs.anki = {
    enable = true;

    theme = "dark";
    minimalistMode = true;

    # Disable pressing spacebar to rate a card
    # I only ever use this by accident
    spacebarRatesCard = false;

    sync = {
      autoSync = true;
      syncMedia = true;

      autoSyncMediaMinutes = 10;

      keyFile = config.sops.secrets.anki_synckey.path;
      usernameFile = config.sops.secrets.email.path;
    };
  };
}
