# A majority of this configures the peacock server emulator, which bypasses the official ioi servers and basically makes the game better.
{inputs, ...}: {
  flake.nixosModules.desktop_steam = {
    config,
    pkgs,
    lib,
    ...
  }: let
    backup = config.home-manager.users.dastarruer.services.restic;
    peacockDir = "${config.home.homeDirectory}/.config/peacock-linux";
    port = 3000;
    peacockScript = pkgs.writeShellApplication {
      name = "peacock-setup";
      runtimeInputs = with pkgs; [
        nodejs_24
        curl
        unzip
        coreutils
        gnugrep
      ];
      text = ''
        # Define ANSI escape codes for text formatting
        BOLD='\e[1m'
        RESET='\e[0m'
        RED='\e[31m'
        GREEN='\e[32m'
        BLUE='\e[34m'

        success_message() { echo -e "[''${GREEN}''${BOLD}✔''${RESET}] $1!"; }
        error_message() { echo -e "[''${RED}''${BOLD}Error''${RESET}] $1"; }
        info_message() { echo -e "\n[''${BLUE}''${BOLD}Info''${RESET}] $1"; }

        # Ensure we are in the right place
        mkdir -p "${peacockDir}"
        cd "${peacockDir}"

        # Grab Peacock if needed
        if [ ! -f "./Peacock/chunk0.js" ]; then
            # ShellCheck Fix: Added quotes and simplified logic
            LATEST_RELEASE=$(curl -L -s -H 'Accept: application/json' https://github.com/thepeacockproject/peacock/releases/latest | sed -e 's/.*"tag_name":"\([^"]*\)".*/\1/')
            FOLDER_NAME="Peacock-''${LATEST_RELEASE}-linux"
            FILE_NAME="''${FOLDER_NAME}.zip"

            info_message "Grabbing Peacock ''${LATEST_RELEASE}"

            if curl -sSLJO -H "Accept: application/octet-stream" "https://github.com/thepeacockproject/Peacock/releases/download/''${LATEST_RELEASE}/''${FILE_NAME}" &&
               unzip -q "''${FILE_NAME}" &&
               rm "''${FILE_NAME}" &&
               mv "''${FOLDER_NAME}" Peacock; then
                success_message "Peacock downloaded"
            else
                error_message "We hit a problem getting Peacock"
                exit 1
            fi
        else
            success_message "Peacock already installed"
        fi

        # Copy files to Steam
        STEAM_DIR="''${HOME}/.local/share/Steam"
        VDF_FILE="''${STEAM_DIR}/steamapps/libraryfolders.vdf"

        if [ -f "''${VDF_FILE}" ]; then
            # ShellCheck Fix: Quoted variables
            STEAM_PATHS=$(grep -oP '"path"\s+"\K[^"]+' "''${VDF_FILE}")
            HITMAN_FOUND=false

            for i in ''${STEAM_PATHS}; do
                TARGET_DIR="''${i}/steamapps/common/HITMAN 3"
                if [ -d "''${TARGET_DIR}" ]; then
                    HITMAN_FOUND=true
                    info_message "Found Hitman 3 in ''${TARGET_DIR}"

                    # Note: WineLaunch.bat must exist in your peacockDir for this to work
                    if cp Peacock/PeacockPatcher.exe "''${TARGET_DIR}/" && \
                       cp "${inputs.peacock}/legacy/WineLaunch.bat" "''${TARGET_DIR}/"; then
                        success_message "Copied Patcher and WineLaunch.bat to successfully!"
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
        # Without this, the systemd service finishes and stops immediately.
        if [ -f "Peacock/chunk0.js" ]; then
            info_message "Starting Peacock Server..."
            cd Peacock
            PORT=${toString port} exec node chunk0.js
        fi
      '';
    };
  in {
    programs.steam.config.apps.hitmanwoa = {
      id = 1659040;
      launchOptions = {
        args = [
          "-skip_launcher"
        ];
      };
    };

    systemd.user.tmpfiles.rules = [
      "d ${peacockDir} - - - - -"
    ];

    systemd.user.services.peacock = {
      Unit.Description = "Peacock";
      Service = {
        WorkingDirectory = peacockDir;
        ExecStart = "${lib.getExe peacockScript}";
      };
      Install.WantedBy = ["multi-user.target"];
    };

    home-manager.services.backup.backupPaths = lib.mkIf backup.enable [
      # Hitman mods
      "${config.home.homeDirectory}/.local/share/Steam/steamapps/common/HITMAN 3/Simple Mod Framework"
      "${config.home.homeDirectory}/.local/share/Steam/steamapps/common/HITMAN 3/README.md"

      # Freelancer variations stuff
      "${config.home.homeDirectory}/.local/share/Steam/steamapps/common/HITMAN 3/Retail/mods/MissionCompanion.dll"
      "${config.home.homeDirectory}/.local/share/Steam/steamapps/common/HITMAN 3/Retail/mods/FreelancerVariations.json"
      "${config.home.homeDirectory}/.local/share/Steam/steamapps/common/HITMAN 3/Retail/mods/missioncompanion.ini"

      # Peacock save data
      "${peacockDir}/Peacock/userdata"
    ];
  };
}
