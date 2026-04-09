{inputs, ...}: {
  perSystem = {system, ...}: {
    flake.nixosModules.desktop_vscode = {
      config,
      pkgs,
      ...
    }: {
      home-manager.users.dastarruer = let
        profile = config.home-manager.desktop.vscode.profile;
        vscode-extensions = inputs.vscode-extensions.extensions.${pkgs.stdenv.system}.vscode-marketplace;
      in {
        # Globally installed extensions
        programs.vscode.profiles.${profile} = {
          extensions = [
            vscode-extensions.aaron-bond.better-comments
            pkgs.vscode-extensions.usernamehw.errorlens

            # Necessary to have both
            pkgs.vscode-extensions.github.copilot
            pkgs.vscode-extensions.github.copilot-chat
          ];

          userSettings = {
            "errorLens.toggle" = true;
          };
        };
      };
    };
  };
}
