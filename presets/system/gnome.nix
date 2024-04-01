{ config, lib, pkgs, ... }: with lib; {
  options = {
    presets.system.gnome.enable = mkEnableOption "the GNOME system preset";
  };

  config = mkIf config.presets.system.gnome.enable {
    environment.gnome.excludePackages = with pkgs; [
      gedit
      gnome.cheese
      gnome.epiphany
      gnome.geary
      gnome.gnome-contacts
      gnome-tour
    ];

    environment.systemPackages = with pkgs; [
      gnome.gnome-tweaks
    ];

    programs.dconf.enable = true;

    services.xserver.enable = true;
    services.xserver.desktopManager.gnome.enable = true;
    services.xserver.displayManager.gdm.enable = true;
  };
}
