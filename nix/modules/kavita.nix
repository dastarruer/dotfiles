{...}: {
  services.kavita = {
    enable = true;

    # The file used for authentication or something
    tokenKeyFile = /etc/kavita-tokenkey;
  };

  # chatgpt's solution to symlink ~/Documents/kavita to /srv/kavita, while giving kavita access to /srv/kavita
  systemd.tmpfiles.rules = [
    "L /srv/kavita - - - - /home/dastarruer/Documents/kavita"
  ];
}
