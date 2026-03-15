{
  vscode-extensions,
  config,
  ...
}: let
  profile = config.home-manager.desktop.vscode.profile;
in {
  programs.vscode.profiles.${profile} = {
    extensions = [
      vscode-extensions.bradlc.vscode-tailwindcss
    ];

    userSettings = {
      "tailwindCSS.includeLanguages" = {
        "svelte" = "html";
      };
      "editor.quickSuggestions" = {
        "strings" = "on";
      };
    };
  };
}
