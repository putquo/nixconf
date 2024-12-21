{ super, ... }@_haumeaArgs:
{ pkgs, ... }@_nixosModuleArgs: {
  imports = [
    super.pc
  ];

  services.udev.packages = [
    pkgs.android-udev-rules
  ];
}
