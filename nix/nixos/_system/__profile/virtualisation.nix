{ ... }@haumeaArgs:
{ pkgs, ... }@nixosModuleArgs: {
  environment.systemPackages = [
    pkgs.spice
    pkgs.spice-gtk
    pkgs.spice-protocol
    pkgs.virt-viewer
  ];


  virtualisation.libvirtd = {
    enable = true;

    qemu = {
      package = pkgs.qemu_kvm;
      ovmf = {
        enable = true;
        packages = [ pkgs.OVMFFull.fd ];
      };
      swtpm.enable = true;
    };
  };

  programs.virt-manager.enable = true;
}
