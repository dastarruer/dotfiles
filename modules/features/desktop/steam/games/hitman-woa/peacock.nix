# A majority of this configures the peacock server emulator, which bypasses the official ioi servers and basically makes the game better.
{inputs, ...}: {
  flake.nixosModules.desktop_steam = {
    config,
    pkgs,
    lib,
    ...
  }: let
    backup = config.custom.backup;
    hmConfig = config.home-manager.users.dastarruer;
    iniFormat = pkgs.formats.ini {};

    peacockDir = "${hmConfig.home.homeDirectory}/.config/peacock-linux";
    peacockZip = pkgs.fetchzip {
      url = "https://github.com/thepeacockproject/Peacock/releases/download/v8.9.1/Peacock-v8.9.1-linux.zip";
      hash = "sha256-DMSWg9jeEdZ6vWF5mxQtx8Is2GAje/VtmKIWlzkQ+6I=";
    };
    port = 3000;
    peacockScript = pkgs.writeShellApplication {
      name = "peacock-setup";
      runtimeInputs = with pkgs; [
        nodejs_24
        coreutils
        gnugrep
      ];
      text = ''
        BOLD='\e[1m'
        RESET='\e[0m'
        RED='\e[31m'
        GREEN='\e[32m'
        BLUE='\e[34m'

        success_message() { echo -e "[''${GREEN}''${BOLD}✔''${RESET}] $1!"; }
        error_message() { echo -e "[''${RED}''${BOLD}Error''${RESET}] $1"; }
        info_message() { echo -e "\n[''${BLUE}''${BOLD}Info''${RESET}] $1"; }

        mkdir -p "${peacockDir}"
        cd "${peacockDir}"

        # Userdata lives OUTSIDE the versioned Peacock/ dir so it survives reinstalls
        mkdir -p userdata

        INSTALLED_VERSION=""
        [ -f "./Peacock/.nix-version" ] && INSTALLED_VERSION=$(cat "./Peacock/.nix-version")

        if [ "''${INSTALLED_VERSION}" != "${peacockZip}" ]; then
            rm -rf ./Peacock
            cp -r --no-preserve=mode "${peacockZip}" ./Peacock
            rm -rf ./Peacock/userdata
            ln -s ../userdata ./Peacock/userdata
            rm -rf ./Peacock/plugins
            ln -s ../plugins ./Peacock/plugins
            echo "${peacockZip}" > ./Peacock/.nix-version
        fi

        # Copy patcher files to Steam
        STEAM_DIR="''${HOME}/.local/share/Steam"
        VDF_FILE="''${STEAM_DIR}/steamapps/libraryfolders.vdf"

        if [ -f "''${VDF_FILE}" ]; then
            STEAM_PATHS=$(grep -oP '"path"\s+"\K[^"]+' "''${VDF_FILE}")
            HITMAN_FOUND=false

            for i in ''${STEAM_PATHS}; do
                TARGET_DIR="''${i}/steamapps/common/HITMAN 3"
                if [ -d "''${TARGET_DIR}" ]; then
                    HITMAN_FOUND=true
                    info_message "Found Hitman 3 in ''${TARGET_DIR}"

                    if cp Peacock/PeacockPatcher.exe "''${TARGET_DIR}/" && \
                       cp "${inputs.peacock}/legacy/WineLaunch.bat" "''${TARGET_DIR}/"; then
                        success_message "Copied Patcher and WineLaunch.bat successfully!"
                    else
                        error_message "Failed to copy Patcher or WineLaunch.bat (Check if WineLaunch.bat exists in ${peacockDir})"
                    fi
                fi
            done

            if [ "''${HITMAN_FOUND}" = false ]; then
               error_message "Hitman 3 folder not found in Steam libraries."
            fi
        fi

        # START THE SERVER
        if [ -f "Peacock/chunk0.js" ]; then
            info_message "Starting Peacock Server..."
            cd Peacock
            PORT=${toString port} exec node chunk0.js
        fi
      '';
    };
  in {
    programs.steam.config = {
      # hitman
      apps."1659040".files.game.place = {
        # Peacock prerequisites
        "Retail/mods/onlinetools.ini" = {
          source = iniFormat.generate "onlinetools" {
            online = {
              optional_dynamic_resources = true;
              bypass_cert_pinning = true;
              enable_dynamic_resources = true;
              always_send_auth_header = true;
              use_http = true;
            };
            domains = {
              saved = "localhost:${toString port}";
              default = 0;
            };
          };
          mode = "lock";
        };
      };
    };

    custom.backup.backupPaths = lib.mkIf backup.enable [
      # Peacock save data
      "${peacockDir}/userdata"
    ];

    home-manager.users.dastarruer = {
      # place peacock plugins
      home.file."${peacockDir}/plugins" = {
        source = ./files/plugins;
        force = true;
      };

      systemd.user.tmpfiles.rules = [
        "d ${peacockDir} - - - - -"
      ];

      systemd.user.services.peacock = let
        hitmanTarget = config.programs.steam.config.apps."1659040".systemd.target.unitName;
      in {
        Unit = {
          Before = [hitmanTarget]; # Wait for peacock to start before opening hitman
          PartOf = [hitmanTarget];
        };
        Service = {
          WorkingDirectory = peacockDir;
          ExecStart = "${lib.getExe peacockScript}";
          Restart = "always";
          RestartSec = 3;
        };
        Install.WantedBy = [hitmanTarget];
      };
    };
  };
}
