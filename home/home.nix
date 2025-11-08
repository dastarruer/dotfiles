{
  lib,
  inputs,
  ...
}: {
  imports = [
    ./modules/default.nix

    inputs.sops-nix.homeManagerModules.sops
  ];

  # Set up user
  home = {
    # Set username and home directory
    username = "dastarruer";
    homeDirectory = lib.mkForce "/home/dastarruer";

    # I couldn't tell you what this does but oh well
    stateVersion = "22.11";
  };

  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;

  # Set some necessary sops settings
  sops = {
    age.keyFile = "/home/dastarruer/.config/sops/age/keys.txt";
    defaultSopsFile = ../secrets/secrets.yaml;

    # Put secrets here so on reinstall no errors pop up
    secrets = {
      name = {};
      email = {};
    };
  };

  # Enable configuration for mime, whatever that means...
  xdg.mimeApps.enable = true;

  # Disable stylix configuration for certain apps
  stylix.targets = {
    # Note that these requires manual theming
    vscode.enable = false;
    gtk.enable = false;

    # These are fine
    hyprland.enable = false;
    anki.enable = false;
    spicetify.enable = false;
    waybar.enable = false;
    dunst.enable = false;
  };

  # Settings to make fonts less blurry
  fonts.fontconfig = {
    enable = true;
    antialiasing = true;
    hinting = "slight";
    subpixelRendering = "rgb";
  };
}
