{pkgs, ...}: {
  services.hypridle = {
    enable = true;
  };

  # Idk why but services.hypridle doesnt work
  home.packages = with pkgs; [
    hypridle
  ];
}
