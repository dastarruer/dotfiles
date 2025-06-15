{ config, pkgs, ... }:

{
  # Define a user account
  programs.fish.enable = true;
  users.users.dastarruer = {
    shell = pkgs.fish;
    isNormalUser = true;
    description = "Ayush Pramanik";
    extraGroups = [ "networkmanager" "wheel" ];
  };
}