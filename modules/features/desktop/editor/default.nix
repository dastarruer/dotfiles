{...}: {
  flake.nixosModules.desktop_editor = {lib, ...}: {
    options.custom = {
      editor = lib.mkOption {
        type = lib.types.enum ["vscode" "zed"];
        default = "vscode";
        description = "Set the code editor to be used.";
      };
    };
  };
}
