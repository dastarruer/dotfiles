# Check here (https://discourse.nixos.org/t/declare-firefox-extensions-and-settings/36265) for more stuff
{
  inputs,
  pkgs,
  ...
}: let
  # Folder under which all firefox stuff goes
  firefoxProfile = "default";
in {
  imports = [
    ./containers.nix
    ./extensions.nix
    ./settings.nix
    ./theme.nix
  ];

  programs.firefox = {
    enable = true;

    # Use firefox nightly
    package = inputs.firefox-nightly.packages.${pkgs.system}.firefox-nightly-bin;
  };

  # Tell stylix to style this profile
  stylix.targets.firefox.profileNames = ["${firefoxProfile}"];
}
