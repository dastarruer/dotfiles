{config, ...}: let
  kavitaTokenkeyPath = /etc/kavita-tokenkey;
in {
  sops.secrets.kavita_tokenkey = {
    owner = config.users.users.dastarruer.name;
    group = config.users.users.dastarruer.group;
    path = "${kavitaTokenkeyPath}";
    mode = "0600";
  };

  services.kavita = {
    enable = true;

    # The file used for authentication or something
    tokenKeyFile = kavitaTokenkeyPath;
  };

  # chatgpt's solution to symlink ~/Documents/kavita to /srv/kavita, while giving kavita access to /srv/kavita
  systemd.tmpfiles.rules = [
    "L /srv/kavita - - - - /home/dastarruer/Documents/kavita"
  ];
}
