{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./home/fish.nix
  ];

  # Set up user
  home = {
    # Set username and home directory
    username = "dastarruer";
    homeDirectory = lib.mkForce "/home/dastarruer";

    # file = {
    #   ".config/fish".source = ./fish;
    # };

    packages = with pkgs; [
      starship
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
