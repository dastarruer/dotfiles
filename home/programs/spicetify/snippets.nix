{
  pkgs,
  inputs,
  ...
}: let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system};
in {
  # CSS snippets to make spotify look even better
  programs.spicetify.enabledSnippets = with spicePkgs.snippets; [
    disableRecommendations
    smoothPlaylistRevealGradient
    disableRecommendations
    pointer
    modernScrollbar
    hideDownloadButton
    hideFriendActivityButton
    hideFullScreenButton
    roundedButtons
    removeTopSpacing
    hideFullScreenButton
    hideMiniPlayerButton
    roundedImages
  ];
}
