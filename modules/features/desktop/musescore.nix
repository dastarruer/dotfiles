{...}: {
  flake.nixosModules.desktop_musescore = {
    config,
    pkgs,
    lib,
    ...
  }: let
    backup = config.custom.backup;
    saveDir = "${config.home-manager.users.dastarruer.home.homeDirectory}/Documents/MuseScore4/Scores";
    # TODO: remove once https://github.com/NixOS/nixpkgs/pull/573316 is merged
        patchedNixpkgs = pkgs.applyPatches {
          name = "nixpkgs-musescore-ffmpeg-v8";
          src = pkgs.path;
          patches = [
            (pkgs.fetchpatch {
              url = "https://github.com/NixOS/nixpkgs/commit/d9398f77aa58d4f98aff43882b5a4c1303a24eeb.patch";
              hash = "sha256-xmuJcaryjdaBuS8+mg7cjWayC3CtpYD4SQh3/moESRE=";
            })
          ];
        };
        patchedPkgs = import patchedNixpkgs {
              inherit (pkgs.stdenv.hostPlatform) system;
            };
  in {
    custom.backup.backupPaths = lib.mkIf backup.enable [saveDir];
    home-manager.users.dastarruer = {
      home.packages = with pkgs; [
        patchedPkgs.musescore
        muse-sounds-manager
      ];
    };
  };
}
