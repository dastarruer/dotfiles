{
  pkgs,
  inputs,
  ...
}: {
  # List packages installed in system profile
  environment.systemPackages = with pkgs; [
    kitty
    vscode-fhs
    git
    gh
    stow
    neofetch
    starship
    zoxide
    cargo
    fzf
    playerctl
    libnotify
    nixd
    alejandra
    firefox
    btop
    python3
    pywal16
  ];
  
  # didn't fetchPypi because the nixOS patched version (2.8.0) is only on PyPI-testing
let pywalfox = buildPythonPackage {
  pname = "pywalfox";
  version = "2.8.0rc1";

  src = fetchFromGitHub {
    owner = "Frewacom";
    repo = "pywalfox-native";
    rev = "7ecbbb193e6a7dab424bf3128adfa7e2d0fa6ff9";
    hash = "sha256-i1DgdYmNVvG+mZiFiBmVHsQnFvfDFOFTGf0GEy81lpE=";
  };
};
  # For nixd i think
  nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];
}
