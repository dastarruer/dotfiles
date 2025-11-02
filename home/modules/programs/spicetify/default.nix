# HELLO FUTURE ME basically spicetify on nix will not work if you also install spotify in packages.nix so yeah
# https://gerg-l.github.io/spicetify-nix/usage.html
{
  pkgs,
  inputs,
  ...
}: let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system};
in {
  # Import the spicetify home manager module and other files
  imports = [
    inputs.spicetify-nix.homeManagerModules.spicetify

    ./extensions.nix
    ./snippets.nix
    ./theme.nix
  ];

  programs.spicetify = {
    enable = true;

    # Custom apps
    enabledCustomApps = with spicePkgs.apps; [
      marketplace
    ];

    # Chromium devtools
    alwaysEnableDevTools = true;

    wayland = true;
  };
}
