{lib, ...}: {
  programs.obs-studio.enable = true;

  # Create the save dir for obs
  home.activation.createScreenRecordingsDir = lib.hm.dag.entryAfter ["writeBoundary"] ''
    mkdir -p "$HOME/Videos/screen-recordings"
  '';
}
