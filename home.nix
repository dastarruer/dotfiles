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

    # Set PATH variables
    sessionPath = [
      "$HOME/bin"
    ];

    # I couldn't tell you what this does but oh well
    stateVersion = "22.11";
  };

  # Disable stylix configuration for waybar
  stylix.targets.waybar.enable = false;
}
