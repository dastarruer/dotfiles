{config, ...}: let
  profile = config.home-manager.desktop.vscode.profile;
in {
  programs.vscode.profiles.${profile}.userSettings = {
    "nix.serverPath" = "nixd";
    "nix.enableLanguageServer" = true;
    "nixpkgs" = {
      "expr" = "import <nixpkgs { }";
    };
    "formatting" = {
      "command" = ["alejandra"];
    };
    "options" = {
      "nixos" = {
        "expr" = "(builtin.getFlake \"github:dastarruer/dotfiles\").nixosConfigurations.dastarruer.options"; # Change dastarruer to hostname if ever changes
      };
      "[nix]" = {
        editor.defaultFormatter = "kamadorueda.alejandra";
      };
    };
  };
}
