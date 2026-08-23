{ ... }@haumeaArgs:
{ pkgs, ... }@nixosModuleArgs: {
  hardware.xpadneo.enable = true;

  programs.gamescope.enable = true;
  programs.gamescope.enableWsi = true;

  programs.steam.enable = true;
  programs.steam.extraCompatPackages = [
    pkgs.proton-ge-bin
  ];
  programs.steam.localNetworkGameTransfers.openFirewall = true;
  programs.steam.gamescopeSession.enable = true;
  programs.steam.gamescopeSession.args = [
    "-W 3840"
    "-w 3840"
    "-H 1600"
    "-h 1600"
    "-r 120"
    "--adaptive-sync"
    "--hdr-enabled"
    "--hdr-itm-enabled"
    "--mangoapp"
    "--rt"
  ];
  programs.steam.gamescopeSession.steamArgs = [
    "-pipewire-dmabuf"
    "-gamepadui"
    "-steamos3"
    "-steampal"
  ];
}
