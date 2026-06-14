{inputs, ...}: {
  flake.nixosModules.desktop_steam = {
    config,
    pkgs,
    lib,
    ...
  }: let
    hmConfig = config.home-manager.users.dastarruer;
    ludusavi = hmConfig.services.ludusavi;
    wayland = config.custom.wm.wayland;
  in {
    imports = [
      inputs.steam-config-nix.nixosModules.default
    ];

    # Enable the new ntsync kernel module for improved multithreading performance w newer versions of proton/wine
    boot.kernelModules = ["ntsync"];

    programs.gamemode = {
      enable = true;
      enableRenice = true;
      settings = {
        general = {
          softrealtime = "auto";
          renice = 10;
        };
      };
    };

    # Allow gamemode to renice processes
    users.users.dastarruer.extraGroups = ["gamemode"];

    programs.gamescope = {
      enable = true;
      capSysNice = true;
    };

    programs.steam = {
      enable = true;
      # https://www.reddit.com/r/NixOS/comments/1ri2dvk/psa_you_can_set_global_environment_variables_for/
      # Idk where to find all these env variables, so thanks again gemini!
      package = pkgs.steam.override {
        extraEnv = {
          # Tells the system to use Gamemode's optimizations automatically for every game
          # The only way i've found to start gamemode via an env var (https://github.com/FeralInteractive/gamemode#requesting-gamemode)
          LD_PRELOAD = "$LD_PRELOAD:/usr/\$LIB/libgamemodeauto.so.0";

          # Forces the high-performance 'RADV' driver for your Renoir iGPU
          # This prevents accidental fallback to slower software rendering
          AMD_VULKAN_ICD = "RADV";

          # Drastically increases the disk space allowed for compiled shaders
          # This prevents 'shader compilation stutter' during gameplay by keeping
          # more pre-rendered assets ready on your disk
          MESA_SHADER_CACHE_MAX_SIZE = "16G";
          MESA_GLSL_CACHE_MAX_SIZE = "16G";

          # Integration for Gamescope
          # Forces the use of the Wayland backend for the micro-compositor
          SHAPE_WAYLAND = lib.mkIf wayland "1";

          # Standardizes video/vulkan behavior to avoid driver conflicts
          WINE_VK_VULKAN_ONLY = "1";

          # Force proton to use ntsync
          PROTON_USE_NTSYNC = "1";
        };
      };

      protontricks.enable = true;
      gamescopeSession.enable = true;
      extest.enable = true; # Wayland controller support

      remotePlay.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;

      extraCompatPackages = [pkgs.proton-ge-bin];
    };

    programs.steam.config = {
      enable = true;
      closeSteam = true;
      defaultCompatTool = "GE-Proton";
    };

    home-manager.users.dastarruer = {
      services.ludusavi.settings.roots = lib.mkIf ludusavi.enable [
        {
          path = "~/.local/share/Steam";
          store = "steam";
        }
      ];
    };
  };
}
