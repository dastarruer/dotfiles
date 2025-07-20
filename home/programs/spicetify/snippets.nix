{
  pkgs,
  inputs,
  ...
}: let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system};
in {
  # CSS snippets to make spotify look even better
  programs.spicetify.enabledSnippets = with spicePkgs.snippets; [
    # Disable some things
    disableRecommendations

    # Remove some things
    removeGradient
    removeTopSpacing

    # Hide some things
    hideDownloadButton
    hideFriendActivityButton
    hideFullScreenButton
    hideMiniPlayerButton
    hideLyricsButton

    # Round some things
    roundedButtons
    roundedImages

    # Fix some things
    fixNowPlayingIcon
    fixLikedButton

    # Other
    pointer
    modernScrollbar
  ];
}
