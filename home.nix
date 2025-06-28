{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: let
in {
  imports = [
    ./home/fish.nix
    ./home/firefox.nix
    ./home/flatpak.nix
    ./home/spicetify.nix
    ./home/packages.nix
  ];

  # Set up user
  home = {
    # Set username and home directory
    username = "dastarruer";
    homeDirectory = lib.mkForce "/home/dastarruer";

    # Symlink a bunch of files
    activation.symlinkFiles = lib.hm.dag.entryAfter ["writeBoundary"] ''
      chmod +x ${config.home.homeDirectory}/.dotfiles/symlink.sh
      ${config.home.homeDirectory}/.dotfiles/symlink.sh
    '';

    # Set PATH variables
    sessionPath = [
      "$HOME/bin"
    ];

    # I couldn't tell you what this does but oh well
    stateVersion = "22.11";
  };

  programs = {
    home-manager.enable = true;

    # Fish stuff
    starship.enable = true;
    zoxide.enable = true;
  };
}
