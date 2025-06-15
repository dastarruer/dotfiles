{ config, pkgs, ... }:

{
    imports = [
      ./users.nix
      ./locale.nix
    ];
}