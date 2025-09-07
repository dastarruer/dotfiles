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
    ./settings.nix
    ./search.nix
    ./extensions
    ./theme
  ];

  programs.firefox = {
    enable = true;

    # Use firefox nightly
    package = inputs.firefox-nightly.packages.${pkgs.system}.firefox-nightly-bin;
  };

  stylix.targets.firefox = {
    # Tell stylix to style this profile
    profileNames = ["${firefoxProfile}"];

    colorTheme.enable = true;
  };
}
