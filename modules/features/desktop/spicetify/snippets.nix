{
  inputs,
  config,
  lib,
  ...
}: {
  perSystem = {system, ...}: {
    flake.nixosModules.desktop_spicetify = {...}: let
      spicePkgs = inputs.spicetify-nix.legacyPackages.${system};
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
  };
}
