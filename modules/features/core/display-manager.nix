{...}: {
  flake.nixosModules.core = {...}: {
    services.displayManager = {
      enable = true;
      defaultSession = "hyprland";

      sddm = {
        enable = true;
        wayland.enable = true;
      };

      autoLogin = {
        enable = true;
        user = "dastarruer";
      };
    };
  };
}
