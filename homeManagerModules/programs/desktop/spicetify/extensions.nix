{spicePkgs, ...}: {
  programs.spicetify.enabledExtensions = with spicePkgs.extensions; [
    adblockify
    hidePodcasts
    loopyLoop
    seekSong
    betterGenres
  ];
}
