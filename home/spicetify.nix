# HELLO FUTURE ME basically spicetify on nix will not work if you also install spotify in packages.nix so yeah
# https://gerg-l.github.io/spicetify-nix/usage.html
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

  programs.spicetify = {
    enable = true;

    # Extensions
    enabledExtensions = with spicePkgs.extensions; [
      adblockify
      hidePodcasts
      shuffle
      loopyLoop
    ];

    # CSS snippets to make spotify look even better
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
      hideFullScreenButton
      hideMiniPlayerButton
    ];

    # Custom apps
    enabledCustomApps = with spicePkgs.apps; [
      marketplace
    ];

    theme = spicePkgs.themes.onepunch;

    colorScheme = "dark";

    wayland = true;
  };
}
