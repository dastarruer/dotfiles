{...}: {
  flake.nixosModules.self-hosted_webdav = {
    config,
    lib,
    ...
  }: let
    storagePath = "/var/lib/webdav";
    usernamePath = config.sops.secrets."webdav/user".path;
    passwordPath = config.sops.secrets."webdav/password".path;
    backup = config.custom.backup;
  in {
    sops.secrets = {
      "webdav/user" = {};
      "webdav/password" = {};
    };

    custom.backup.backupPaths = lib.mkIf backup.enable [
      storagePath
    ];

    services.webdav = {
      enable = true;
      settings = {
        address = "127.0.0.1"; # Nginx will expose it
        port = 8080;
        directory = storagePath;
        permissions = "CRUD";
        behindProxy = true;
        cors = {
          enabled = true;
          credentials = true;
          allowed_hosts = ["*"];
          allowed_headers = [
            "Authorization"
            "Content-Type"
            "Content-Range"
            "Depth"
            "Destination"
            "If"
            "Lock-Token"
            "Overwrite"
            "TimeOut"
            "Translate"
            "X-Update-Range"
          ];
          allowed_methods = [
            "COPY"
            "DELETE"
            "GET"
            "HEAD"
            "LOCK"
            "UNLOCK"
            "MKCOL"
            "MOVE"
            "OPTIONS"
            "PATCH"
            "POST"
            "PROPFIND"
            "PROPPATCH"
            "PUT"
          ];
        };
        users = [
          {
            username = lib.mkIf (builtins.pathExists usernamePath) (lib.removeSuffix "\n" (builtins.readFile usernamePath));
            password = lib.mkIf (builtins.pathExists passwordPath) (lib.removeSuffix "\n" (builtins.readFile passwordPath));
          }
        ];
      };
    };

    services.nginx = {
      enable = true;
      virtualHosts."192.168.100.194" = {
        enableACME = false;
        forceSSL = false;
        addSSL = false;

        locations."/" = {
          proxyPass = "http://127.0.0.1:8080";
          extraConfig = ''
            client_max_body_size 500M;
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header X-Forwarded-Proto $scheme;
          '';
        };
      };
    };

    networking.firewall.allowedTCPPorts = [80 443];

    systemd.tmpfiles.rules = [
      "d ${storagePath} 0775 webdav webdav -"
    ];
  };
}
