{
  config,
  lib,
  pkgs,
  ...
}: {
  systemd.user.enable = true;
  nixpkgs.config.allowUnfree = true;

  # Set up user
  home = {
    # Set username and home directory
    username = "dastarruer";
    homeDirectory = lib.mkForce "/home/dastarruer";

    # No clue what this does
    stateVersion = "25.11";

    sessionVariables = {
      # Allow unfree packages.
      NIXPKGS_ALLOW_UNFREE = "1";

      # Necessary for some screenshot tools
      XDG_SCREENSHOTS_DIR = "${config.home.homeDirectory}/Pictures/screenshots";
    };
  };

  programs.sioyek.enable = true;

  systemd.user.tmpfiles.rules = [
    # Create the save dir for screenshots, deleting files older than 30 days
    "d %h/Pictures/screenshots - - - 30d -"

    # Create the Downloads dir, deleting files older than 5 days
    "d %h/Downloads - - - 5d -"

    # Create the Trash dir, deleting files older than 30 days
    "d %h/.local/share/Trash/files - - - 30d -"
  ];

  programs.home-manager.enable = true;
  services.polkit-gnome.enable = true;

  home-manager = {
    theme = {
      name = "everforest-dark-hard";
      accent = config.lib.stylix.colors.base0B;
    };

    desktop = {
      enable = true;
      foliate.enable = false;
      firefox.enable = true;
      gaming.enable = false;

      pwa = {
        enable = false;
        whatsapp.enable = true;
      };
    };

    cli = {
      enable = true;
      distrobox.enable = false;
      rclone = {
        backupPaths = [
          "${config.home.homeDirectory}/Documents/sheet-music"
          "${config.home.homeDirectory}/Documents/school"
        ];
      };
    };

    window-manager.sherlock.enable = false;
  };
}
