{...}: {
  services.calibre-web = {
    enable = true;
    openFirewall = true;

    # Very secure i know but i cant be bothered to figure out how to give calibre-web access to $HOME
    user = "dastarruer";

    # Enabling this means metadata.db will be read only. this is a stupid thing and i hate it
    # options = {
    #   calibreLibrary = /home/dastarruer/Documents/calibre;
    # };
  };

  # chatgpt's solution to symlink ~/Documents/calibre to /srv/calibre, while giving calibre access to /srv/calibre
  # systemd.tmpfiles.rules = [
  #   "L /srv/calibre - - - - /home/dastarruer/Documents/calibre"
  # ];
}
