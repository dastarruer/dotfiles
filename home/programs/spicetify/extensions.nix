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

  # CSS snippets to make spotify look even better
  programs.spicetify.enabledSnippets = with spicePkgs.snippets; [
    disableRecommendations
    smoothPlaylistRevealGradient
    disableRecommendations
    pointer
    modernScrollbar
    hideDownloadButton
    hideFriendActivityButton
    roundedButtons
    removeTopSpacing
    hideFullScreenButton
    hideMiniPlayerButton
    roundedImages
  ];
}
