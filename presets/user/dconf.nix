{ config, lib, osConfig, pkgs, ... }: with lib; {
  options = {
    presets.user.dconf.enable = mkEnableOption "the dconf user preset";
  };

  config = mkIf config.presets.user.dconf.enable {
    home.packages = with pkgs; [
      orchis-theme
      tela-icon-theme
    ];

    dconf.enable = true;
    dconf.settings = {
      "org/gnome/Console" = {
        use-system-font = false;
        custom-font = "CaskaydiaMono Nerd Font 10";
      };

      "org/gnome/desktop/interface" = {
        icon-theme = "Tela";
      };

      "org/virt-manager/virt-manager/connections" = mkIf osConfig.presets.system.automation.enable {
        autoconnect = [ "qemu:///system" ];
        uris = [ "qemu:///system" ];
      };
    };

    gtk.enable = true;
    gtk.theme = lib.mkForce {
      name = "Orchis";
      package = pkgs.orchis-theme;
    };
  };
}
