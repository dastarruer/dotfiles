{inputs, ...}: {
  # For nixd i think
  nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];
}
