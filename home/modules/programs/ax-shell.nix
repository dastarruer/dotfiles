{
  config,
  inputs,
  ...
}: {
  imports = [
    inputs.ax-shell.homeManagerModules.default
  ];

  programs.ax-shell = {
    enable = true;
    settings = {
      # --- General ---
      terminalCommand = "kitty -e";
      wallpapersDir = "${config.home.homeDirectory}/Pictures/wallpapers";

      # --- Bar & Dock ---
      bar = {
        position = "Top"; # "Top", "Bottom", "Left", "Right"
        theme = "Pills"; # "Pills", "Dense", "Edge"
      };
      # dock.enable = false; # Disable the dock
      panel.theme = "Notch"; # "Notch", "Panel"

      # --- Keybindings ---
      keybindings.launcher = {
        prefix = "SUPER";
        suffix = "SPACE";
      };
    };
  };
}
