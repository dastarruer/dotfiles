{inputs, ...}: {
  flake.nixosModules.desktop_spicetify = {pkgs, ...}: let
    spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system};
  in {
    home-manager.users.dastarruer = {
      programs.spicetify.enabledExtensions = with spicePkgs.extensions; [
        adblockify
        hidePodcasts
        loopyLoop
        seekSong
        betterGenres
      ];
    };
  };
}
