# On install, use admin and admin123 for username and password respectively
{pkgs, ...}: {
  services.calibre-web = {
    enable = true;
    openFirewall = true;

    # Very secure i know but i cant be bothered to figure out how to give calibre-web access to $HOME
    user = "dastarruer";

    listen = {
      ip = "0.0.0.0"; # bind to all interfaces so other devices can connect
      port = 8083;
    };

    options = {
      # Enabling this means metadata.db will be read only. this is a stupid thing and i hate it
      # calibreLibrary = /home/dastarruer/Documents/calibre;

      enableBookConversion = true;
      enableBookUploading = true;
    };
  };

  environment.systemPackages = [pkgs.calibre];
}
