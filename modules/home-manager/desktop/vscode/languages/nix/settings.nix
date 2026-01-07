{...}: {
  programs.vscode.profiles.default.userSettings = {
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
