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
    inputs.flatpaks.homeModule
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

    # User specific packages
    packages = with pkgs; [
      starship
      vesktop
      pywal16
      pywalfox-native
      anki-bin
      flatpak
      vscode-fhs
      xfce.thunar
      firefox
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
