{...}: {
  programs.distrobox = {
    enable = true;
    containers = {
      sql-test = {
        additional_packages = "mysql-server";
        entry = true;
        image = "debian:13";
        init_hooks = [
          "ln -sf /usr/bin/distrobox-host-exec /usr/local/bin/docker"
          "ln -sf /usr/bin/distrobox-host-exec /usr/local/bin/docker-compose"
        ];
      };
    };
  };
}
