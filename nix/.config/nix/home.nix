{
  config,
  pkgs,
  lib,
  ...
}: {
  home = {
    # Set username and home directory
    username = "dastarruer";
    homeDirectory = lib.mkForce "/home/dastarruer";

    # I couldn't tell you what this does but oh well
    stateVersion = "22.11";
  };

  programs.home-manager.enable = true;

  # Enable fish shell
  programs.fish.enable = true;
}
