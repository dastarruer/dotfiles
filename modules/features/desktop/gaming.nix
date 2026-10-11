# Not meant to be imported manually; meant to be imported by other modules
# A few of these settings come frofm https://github.com/Taskerer/SDWEAK
{inputs, ...}: {
  flake.nixosModules.desktop_gaming = {
    pkgs,
    lib,
    ...
  }: {
    nixpkgs.overlays = [
      (final: prev: {
        gamescope = prev.gamescope.overrideAttrs (old: rec {
          version = "3.16.28";
          src = prev.fetchFromGitHub {
            owner = "ValveSoftware";
            repo = "gamescope";
            tag = version;
            fetchSubmodules = true;
            hash = "sha256-6B9Vbr21EHDOVCx27TZk3ruJPqoovEQ1JYtd8F6Siv4="; # build once, paste the real hash
          };
        });
      })
    ];

    boot = {
      # Enable the new ntsync kernel module for improved multithreading performance w newer versions of proton/wine
      kernelModules = ["ntsync"];
    };

    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };

    programs.gamemode = {
      enable = true;
      enableRenice = true;
      settings = {
        general = {
          desiredgov = "performance";
          defaultgov = "powersave";
          renice = 10;
          softrealtime = "auto";
          inhibit_screensaver = 1;
        };
        cpu = {
          park_cores = "no";
          pin_cores = "yes";
        };
        gpu = {
          apply_gpu_optimisations = "accept-responsibility";
          amd_performance_level = "high";
        };

        custom = {
          start = "${lib.getExe pkgs.libnotify} 'GameMode started'";
          end = "${lib.getExe pkgs.libnotify} 'GameMode ended'";
        };
      };
    };

    # Allow gamemode to renice processes
    users.users.dastarruer.extraGroups = ["gamemode"];

    programs.gamescope = {
      # package = lib.mkForce config.multiverse.pinned.gamescope;
      enable = true;
      capSysNice = true;
    };
  };
}
