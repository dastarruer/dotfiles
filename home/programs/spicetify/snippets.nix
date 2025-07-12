{
  pkgs,
  inputs,
  ...
}: let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system};
in {
  # Import the spicetify home manager module
  imports = [
    inputs.spicetify-nix.homeManagerModules.spicetify
  ];

  programs.spicetify.enabledExtensions = with spicePkgs.extensions; [
    adblockify
    hidePodcasts
    shuffle
    loopyLoop
    seekSong
    powerBar
    betterGenres
  ];
}
