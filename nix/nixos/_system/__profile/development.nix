{ ... }@haumeaArgs:
{ pkgs, ... }@nixosModuleArgs: {
  environment.systemPackages = [
    pkgs.fd
    pkgs.jq
    pkgs.openssl
    pkgs.ripgrep
    pkgs.tree
    pkgs.unzip
    pkgs.yq
    pkgs.zip
  ];

  nix.settings.substituters = [
    "https://devenv.cachix.org"
  ];
  nix.settings.trusted-public-keys = [
    "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
  ];

  virtualisation.containers.enable = true;
  virtualisation.docker.enable = true;
}
