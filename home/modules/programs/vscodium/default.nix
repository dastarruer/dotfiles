{pkgs, ...}: {
  imports = [
    ./extensions.nix
    ./settings
    ./languages
  ];

  programs.vscode = {
    enable = true;
    # Use vscodium fhs so lldb works: https://www.reddit.com/r/NixOS/comments/1e724mx/how_can_i_debug_rust_with_vscodium_and/
    package = pkgs.vscodium.fhs;
  };

  # Run vscodium under wayland
  home.sessionVariables.NIXOS_OZONE_WL = "1";
}
