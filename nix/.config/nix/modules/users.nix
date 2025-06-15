{ config, pkgs, ... }:

{
  # Enable fish shell
  programs.fish.enable = true;
  
  # Define a user account
  users.users.dastarruer = {
    shell = pkgs.fish;
    isNormalUser = true;
    description = "Ayush Pramanik";
    extraGroups = [ "networkmanager" "wheel" ];
  };
}