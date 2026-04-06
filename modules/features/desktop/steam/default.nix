{inputs, ...}: {
  flake.nixosModules.desktop_steam = {
    config,
    pkgs,
    lib,
    ...
  }: {
    imports = [
      inputs.steam-config-nix.nixosModules.default
    ];

    hardware.graphics = {
      enable = true;
      enable32Bit = true;
      # These provide the actual translation layers for video playback
      extraPackages = with pkgs; [
        libva-vdpau-driver
        libvdpau-va-gl
      ];
    };

    # The only essential line for AMD hardware support
    services.xserver.videoDrivers = ["amdgpu"];

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

        # Use full cpu power when gaming
        custom = {
          start = "${lib.getExe pkgs.tlp} setcfg CPU_BOOST_ON_AC=1 CPU_SCALING_GOVERNOR_ON_AC=performance PLATFORM_PROFILE_ON_AC=performance";
          end = "${lib.getExe pkgs.tlp} setcfg CPU_BOOST_ON_AC=0 CPU_SCALING_GOVERNOR_ON_AC=powersave PLATFORM_PROFILE_ON_AC=balanced";
        };
      };
    };

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
          GAMEMODERUN = "1";

          # Forces the high-performance 'RADV' driver for your Renoir iGPU
          # This prevents accidental fallback to slower software rendering
          AMD_VULKAN_ICD = "RADV";

          # Drastically increases the disk space allowed for compiled shaders
          # This prevents 'shader compilation stutter' during gameplay by keeping
          # more pre-rendered assets ready on your disk
          MESA_SHADER_CACHE_MAX_SIZE = "16G";
          MESA_GLSL_CACHE_MAX_SIZE = "16G";

          # Gamescope & Wayland Compatibility
          # These ensure Steam and its games talk directly to your Wayland compositor
          XDG_SESSION_TYPE = "wayland";
          SDL_VIDEODRIVER = "wayland";
          QT_QPA_PLATFORM = "wayland";

          # Integration for Gamescope
          # Forces the use of the Wayland backend for the micro-compositor
          SHAPE_WAYLAND = "1";

          # Standardizes video/vulkan behavior to avoid driver conflicts
          WINE_VK_VULKAN_ONLY = "1";

          # Force proton to use ntsync
          PROTON_USE_NTSYNC = "1";
        };
      };

      protontricks.enable = true;
      gamescopeSession.enable = true;
      extraCompatPackages = [pkgs.proton-ge-bin];

      # Wayland controller support
      extest.enable = true;
    };

    programs.steam.config = {
      enable = true;
      closeSteam = true;
      defaultCompatTool = "GE-Proton";
    };

    home-manager.users.dastarruer = let
      ludusavi = config.services.ludusavi;
    in {
      services.ludusavi.settings.roots = lib.mkIf ludusavi.enable [
        {
          path = "~/.local/share/Steam";
          store = "steam";
        }
      ];
    };
  };
}
