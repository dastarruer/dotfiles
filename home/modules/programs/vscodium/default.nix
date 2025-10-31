{
  pkgs,
  config,
  ...
}: {
  imports = [
    ./extensions.nix
    # ./settings
    ./languages
  ];

  programs.vscode = {
    enable = true;
    # Use vscode fhs so lldb works: https://www.reddit.com/r/NixOS/comments/1e724mx/how_can_i_debug_rust_with_vscodium_and/
    # use vscode because devcontainers only works w regular vscode
    package = pkgs.vscodium.fhs;
  };

  # Run vscodium under wayland
  home.sessionVariables.NIXOS_OZONE_WL = "1";

  # Without this, home manager can't symlink files to .config (https://github.com/nix-community/home-manager/issues/1807#issuecomment-3131623755)
  xdg.configFile = {
    "VSCodium/User/settings.json".enable = false;
  };

  # Symlink hyprland config
  home.file.".config/VSCodium/User/settings.json" = {
    source =
      config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/.dotfiles/config/vscodium/settings.json";
  };
}
