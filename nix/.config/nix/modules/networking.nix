{ config, pkgs, ... }:

{
     # Define your hostname.
  networking.hostName = "dastarruer"; 

  # Enable networking
  networking.networkmanager.enable = true;
}