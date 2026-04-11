{...}: {
  flake.nixosModules.desktop_anki = {
    config,
    lib,
    ...
  }: let
    backup = config.custom.backup;

    hmConfig = config.home-manager.users.dastarruer;
    hyprland = hmConfig.wayland.windowManager.hyprland;

    keyPath = hmConfig.sops.secrets.anki_synckey.path;
    emailPath = hmConfig.sops.secrets.email.path;
  in {
    custom.backup.backupPaths = lib.mkIf backup.enable ["${config.home-manager.users.dastarruer.home.homeDirectory}/.local/share/Anki2/User\ 1/backups"];

    home-manager.users.dastarruer = {
      sops.secrets = {
        anki_synckey = {};
        email = {}; # This is also in git.nix, but no errors will show up if this is put here as well
      };

      programs.anki = {
        enable = true;

        theme = "dark";
        minimalistMode = true;

        # Disable pressing spacebar to rate a card
        # I only ever use this by accident
        spacebarRatesCard = false;

        # Since sops-nix does not provide secrets at build time, make sure the secret exists first before configuring this; otherwise many an error will be thrown
        profiles."User 1".sync = lib.mkIf (builtins.pathExists keyPath && builtins.pathExists emailPath) {
          autoSync = true;
          syncMedia = true;

          autoSyncMediaMinutes = 10;

          keyFile = keyPath;
          usernameFile = emailPath;
        };
      };

      wayland.windowManager.hyprland.settings = lib.mkIf hyprland.enable {
        windowrule = [
          "workspace 9 silent,match:class anki"
          "idle_inhibit focus, match:class anki"
        ];
      };
    };
  };
}
