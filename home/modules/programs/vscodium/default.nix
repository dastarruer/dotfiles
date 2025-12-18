{pkgs, ...}: {
  imports = [
    ./extensions.nix
    ./settings
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
}
