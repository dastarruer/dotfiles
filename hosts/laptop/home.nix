{lib, ...}: {
  imports = [
    ../../homeManagerModules/default.nix
  ];

  systemd.user.enable = true;

  # Set up user
  home = {
    # Set username and home directory
    username = "dastarruer";
    homeDirectory = lib.mkForce "/home/dastarruer";

    # I couldn't tell you what this does but oh well
    stateVersion = "25.11";

    sessionVariables = {
      # Allow unfree packages.
      NIXPKGS_ALLOW_UNFREE = "1";

      # Necessary for grimblast and other screenshot tools
      XDG_SCREENSHOTS_DIR = "/home/dastarruer/Pictures/screenshots";
    };
  };

  systemd.user.tmpfiles.rules = [
    # Create the save dir for screenshots, deleting files older than 30 days
    "d %h/Pictures/screenshots - - - 30d -"

    # Create the Downloads dir, deleting files older than 5 days
    "d %h/Downloads - - - 5d -"
  ];

  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;

  services.polkit-gnome.enable = true;

  myPrograms = {
    foliate.enable = false;
    sherlock.enable = false;
    distrobox.enable = false;
  };
}
