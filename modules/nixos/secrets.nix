{inputs, ...}: {
  sops = {
    # Path to secrets file
    defaultSopsFile = "${inputs.self.outPath}/secrets/secrets.yaml";
    defaultSopsFormat = "yaml";

    # Path to age key
    age.keyFile = "/home/dastarruer/.config/sops/age/keys.txt";
  };
}
