{...}: {
  flake.nixosModules.cli_direnv = {
    config,
    lib,
    ...
  }: let
    editor = config.custom.desktop.editor;
  in {
    home-manager.users.dastarruer = {
      programs.direnv = {
        enable = true;
        enableFishIntegration = config.programs.fish.enable;

        # For nix flake integration
        nix-direnv.enable = true;
      };

      # Load nix devshells when opening project w editor
      programs.zed-editor.userSettings.load_direnv = lib.mkIf (editor == "zed") "shell_hook";
    };
  };
}
