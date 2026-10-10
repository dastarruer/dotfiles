# Not meant to be imported manually; meant to be imported by other modules
{inputs, ...}: {
  flake.nixosModules.desktop_gaming = {
    pkgs,
    lib,
    ...
  }: {
    # Enable the new ntsync kernel module for improved multithreading performance w newer versions of proton/wine
    boot.kernelModules = ["ntsync"];

    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };

    programs.gamemode = {
      enable = true;
      enableRenice = true;
      settings = {
        general = {
          softrealtime = "auto";
          renice = 10;
        };
        custom = {
          start = "${lib.getExe pkgs.libnotify} 'GameMode started'";
          end = "${lib.getExe pkgs.libnotify} 'GameMode ended'";
        };
      };
    };

    # Allow gamemode to renice processes
    users.users.dastarruer.extraGroups = ["gamemode"];

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
    programs.gamescope = {
      # package = lib.mkForce config.multiverse.pinned.gamescope;
      enable = true;
      capSysNice = true;
    };
  };
}