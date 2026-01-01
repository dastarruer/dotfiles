{...}: {
  programs.obs-studio.enable = true;

  # Create the save dir for obs
  systemd.user.tmpfiles.rules = [
    "d %h/Videos/screen-recordings - - - - -"
  ];
}
