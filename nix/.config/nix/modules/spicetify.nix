# HELLO FUTURE ME basically spicetify on nix will not work if you also install spotify in packages.nix so yeah
# https://gerg-l.github.io/spicetify-nix/usage.html
{
  pkgs,
  inputs,
  ...
}: let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system};
in {
  programs.spicetify = {
    enable = true;
    enabledExtensions = with spicePkgs.extensions; [
      adblockify
      hidePodcasts
      shuffle
    ];

    enabledSnippets = with spicePkgs.snippets; [
      disableRecommendations
      smoothPlaylistRevealGradient
      disableRecommendations
      pointer
      modernScrollbar
      hideDownloadButton
      hideFriendActivityButton
      roundedButtons
      removeTopSpacing
    ];

    theme = spicePkgs.themes.onepunch;

    colorScheme = "dark";

    wayland = true;
  };
}
