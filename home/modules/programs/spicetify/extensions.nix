{
  pkgs,
  inputs,
  ...
}: let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system};
in {
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
