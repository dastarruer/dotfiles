{
  lib,
  config,
  ...
}: {
  imports = [
    ./home/default.nix
  ];

  # Set up user
  home = {
    # Set username and home directory
    username = "dastarruer";
    homeDirectory = lib.mkForce "/home/dastarruer";

    # I couldn't tell you what this does but oh well
    stateVersion = "22.11";
  };

  # Set some necessary sops settings
  sops = {
    age.keyFile = "/home/dastarruer/.config/sops/age/keys.txt";
    defaultSopsFile = ./secrets/secrets.yaml;
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
