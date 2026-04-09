{
  inputs,
  pkgs,
  ...
}: {
  flake.nixosModules.desktop_spicetify = {...}: let
    spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system};
  in {
    home-manager.users.dastarruer = {
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

        # Fix some things
        fixNowPlayingIcon
        fixLikedButton

        # Other
        beSquare
        pointer
        modernScrollbar
      ];
    };
  };
}
