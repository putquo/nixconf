{ name, super, ... }@_haumeaArgs:
{ pkgs, ... }@_nixosModuleArgs: {
  imports = [
    super.hardware.notDetected
    super.platform."x86_64-linux"
  ];

  boot.extraModulePackages = [ ];
  boot.initrd.availableKernelModules = [
    "nvme"
    "sd_mod"
    "sdhci_pci"
    "thunderbolt"
    "usb_storage"
    "xhci_pci"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 4;

  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/7ec304ba-51b2-4548-a48e-730d7ae00cb5";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-uuid/06C8-44DD";
      fsType = "vfat";
    };

  hardware.bluetooth.enable = true;
  hardware.cpu.intel.updateMicrocode = true;
  hardware.enableRedistributableFirmware = true;

  networking.hostName = name;

  services.resolved.enable = true;

  swapDevices = [ ];
  system.stateVersion = "23.11";
}
