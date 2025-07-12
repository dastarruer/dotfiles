{...}: let
  # Firefox theme that I will use
  firefoxTheme = "https://github.com/cascadefox/cascade";

  firefoxProfile = "default";
in {
  # Fetch firefox theme (https://www.reddit.com/r/NixOS/comments/1f5wbjd/installing_a_complex_user_css_for_firefox/)
  home.file = {
    ".mozilla/firefox/${firefoxProfile}/chrome" = {
      source = "${builtins.fetchGit {
        url = firefoxTheme;
        rev = "f8c6bb5a36f24aba61995204ff5497c865e78e50";
      }}/chrome";
      recursive = true;
    };
  };
}
