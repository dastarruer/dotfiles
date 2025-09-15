# Check here for packaging an anki addon: https://github.com/NixOS/nixpkgs/blob/master/pkgs/games/anki/with-addons.nix
{...}: {
  imports = [
    ./addons
  ];

  programs.anki = {
    enable = true;
  };
}
