{ ... }@_haumeaArgs:
{ pkgs, ... }@_nixosModuleArgs: {
  environment.systemPackages = with pkgs; [
    aider-chat
    difftastic
    docker-compose
    claude-code
    fd
    fzf
    just
    jq
    jwt-cli
    poppler
    ripgrep
    theme-sh
    tree
    unar
    yq
  ];

  nix.settings.substituters = [
    "https://devenv.cachix.org"
    "https://helix.cachix.org"
  ];
  nix.settings.trusted-public-keys = [
    "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
    "helix.cachix.org-1:ejp9KQpR1FBI2onstMQ34yogDm4OgU2ru6lIwPvuCVs="
  ];

  virtualisation.containers.enable = true;
  virtualisation.podman.enable = true;
  virtualisation.podman.dockerCompat = true;
  virtualisation.podman.defaultNetwork.settings.dns_enabled = true;
}
