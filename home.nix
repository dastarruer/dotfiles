{lib, ...}: {
  imports = [
    ./home/default.nix
  ];

  # Set up user
  home = {
    # Set username and home directory
    username = "dastarruer";
    homeDirectory = lib.mkForce "/home/dastarruer";

    # Set PATH variables
    sessionPath = [
      "$HOME/bin"
    ];

    # I couldn't tell you what this does but oh well
    stateVersion = "22.11";
  };

  # Disable stylix configuration for certain apps
  stylix.targets = {
    # Note that these requires manual theming
    vscode.enable = false;
    gtk.enable = false;

    # These are fine
    hyprland.enable = false;
    spicetify.enable = false;
    waybar.enable = false;
  };
}
