{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ../../modules/home-manager/default.nix
  ];

  systemd.user.enable = true;

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

  nix = {
    # This line solves the "Failed assertions" error
    package = pkgs.nix;

    settings = {
      # Disable local builds
      max-jobs = 0;
    };
  };

  systemd.user.tmpfiles.rules = [
    # Create the save dir for screenshots, deleting files older than 30 days
    "d %h/Pictures/screenshots - - - 30d -"

    # Create the Downloads dir, deleting files older than 5 days
    "d %h/Downloads - - - 5d -"

    # Create the Trash dir, deleting files older than 30 days
    "d %h/.local/share/Trash/files - - - 30d -"
  ];

  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;

  services.polkit-gnome.enable = true;

  home-manager = {
    desktop = {
      enableAll = true;

      foliate.enable = false;
      #   flameshot.enable = false;
      gaming.enable = false;
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

    window-manager = {
      enable = true;
      hypr.hypridle.enable = false;
      sherlock.enable = false;
    };
  };
}
