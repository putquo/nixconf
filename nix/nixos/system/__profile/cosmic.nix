{ ... }@_haumeaArgs:
{ pkgs, ... }@_nixosModuleArgs: {
  services.desktopManager.cosmic.enable = true;
  services.desktopManager.cosmic.xwayland.enable = true;
  services.displayManager.cosmic-greeter.enable = true;
}
