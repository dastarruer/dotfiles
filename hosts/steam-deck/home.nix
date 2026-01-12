{
  config,
  lib,
  ...
}: {
  imports = [
    ../../modules/home-manager/default.nix
  ];

  systemd.user.enable = true;
  targets.genericLinux.enable = true;

  # Set up user
  home = {
    # Set username and home directory
    username = "deck";
    homeDirectory = lib.mkForce "/home/deck";

    # No clue what this does
    stateVersion = "25.11";

    sessionVariables = {
      # Allow unfree packages.
      NIXPKGS_ALLOW_UNFREE = "1";

      # Necessary for some screenshot tools
      XDG_SCREENSHOTS_DIR = "${config.home.homeDirectory}/Pictures/screenshots";
    };

    # Workaround to make all .desktop files executable
    activation = {
      fixDesktopPermissions = lib.hm.dag.entryAfter ["writeBoundary"] ''
        find ~/.local/share/applications/ -name "*.desktop" -exec chmod +x {} +
        find ~/.nix-profile/share/applications -name "*.desktop" -exec chmod +x {} +
      '';
    };

    # Symlink steam screenshots
    file."Pictures/screenshots".source =
      config.lib.file.mkOutOfStoreSymlink
      "/home/deck/.local/share/Steam/userdata/1782287269/760/remote";
  };

  systemd.user.tmpfiles.rules = [
    # Create the Downloads dir, deleting files older than 5 days
    "d %h/Downloads - - - 5d -"
  ];

  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;

  home-manager = {
    desktop = {
      gaming.enable = true;
      spicetify.enable = false;
      pwa.enable = true;

      firefox = {
        enable = true;
        deckFixes = true;
      };
    };

    cli = {
      shell.enable = true;
      rclone.enable = true;
    };
  };
}
