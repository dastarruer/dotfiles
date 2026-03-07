{pkgs, ...}: {
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

  programs.gamemode.enable = true;
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
      };
    };

    protontricks.enable = true;
    gamescopeSession.enable = true;
    extraCompatPackages = [pkgs.proton-ge-bin];

    # Wayland controller support
    extest.enable = true;
  };
}
