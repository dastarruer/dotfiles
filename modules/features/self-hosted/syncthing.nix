# You can check if this is enabled by checking config.custom.sync.enable
{...}: {
  flake.nixosModules.self-hosted_syncthing = {
    config,
    lib,
    ...
  }: let
    cfg = config.custom.sync;
    hmConfig = config.home-manager.users.dastarruer;

    devices = {
      "cool awesome iphone" = {id = "VUVWW4W-JWY7E2B-7JTZNZU-JJXYLJU-GK2OPVQ-EM6FV6H-I5CNZ7B-WMOZZQX";};
      "cool awesome ipad" = {id = "MP2BZAU-DKAJGUU-RFLNYDQ-GJZU4SL-WDYB77C-FBJNB6A-7C7XLBB-U4BZNAH";};
    };
  in {
    options.custom = {
      sync = {
        # This option only exists to safely check if sync enabled without infinite recursion. Just importing the self-hosted_syncthing module enables it on its own
        enable = lib.mkOption {
          type = lib.types.bool;
          default = true;
          readOnly = true;
        };
        secretsReady = lib.mkOption {
          type = lib.types.bool;
          default = false;
        };
        syncPaths = lib.mkOption {
          default = [];
          description = "Local directories to sync, each with the devices it should be shared with.";
          example = [
            {
              path = "/home/dastarruer/Documents";
              devices = ["cool awesome iphone"];
            }
            {
              path = "/home/dastarruer/Pictures";
              devices = ["cool awesome iphone" "cool awesome ipad"];
            }
          ];
          type = lib.types.listOf (lib.types.submodule {
            options = {
              path = lib.mkOption {
                type = lib.types.str;
                description = "Absolute path of the directory to sync.";
              };
              devices = lib.mkOption {
                type = lib.types.listOf (lib.types.enum (lib.attrNames devices));
                default = [];
                description = "Names of devices to share this path with. Must be keys of the devices set in this module.";
              };
            };
          });
        };
      };
    };

    config = lib.mkIf cfg.enable {
      services.syncthing = {
        enable = true;
        openDefaultPorts = true;
        user = "dastarruer";
        group = "users";
        dataDir = hmConfig.home.homeDirectory;
        configDir = "${hmConfig.xdg.configHome}/syncthing";
        guiAddress = "127.0.0.1:8384";

        settings = {
          inherit devices;

          # Declare one folder per entry in syncPaths, shared with its listed devices
          folders = lib.listToAttrs (map (entry:
            lib.nameValuePair (lib.replaceStrings ["/"] ["_"] entry.path) {
              inherit (entry) path devices;
            })
          cfg.syncPaths);
        };
      };
    };
  };
}
