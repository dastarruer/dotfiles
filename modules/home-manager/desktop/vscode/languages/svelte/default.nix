{
  vscode-extensions,
  config,
  ...
}: let
  profile = config.home-manager.desktop.vscode.profile;
in {
  programs.vscode.profiles.${profile} = {
    extensions = [
      vscode-extensions.svelte.svelte-vscode
    ];

    userSettings = {
      # Enable typescript support
      "svelte.enable-ts-plugin" = true;

      # Formatting settings
      "[svelte]" = {
        "editor.defaultFormatter" = "svelte.svelte-vscode";
        "editor.tabSize" = 2;
      };
    };
  };
}
