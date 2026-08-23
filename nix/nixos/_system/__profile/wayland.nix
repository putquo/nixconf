{ ... }@haumeaArgs:
{ pkgs, ... }@nixosModuleArgs: {
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  environment.sessionVariables.WLR_NO_HARDWARE_CURSORS = "1";
  environment.sessionVariables.XDG_SESSION_TYPE = "wayland";

  environment.systemPackages = [
    pkgs.grim
    pkgs.mpv
    pkgs.slurp
    pkgs.wl-clipboard
    pkgs.wl-screenrec
    pkgs.wlr-randr
  ];

  services.displayManager.enable = true;

  services.greetd.enable = true;

  security.rtkit.enable = true;

  services.pipewire.enable = true;
  services.pipewire.alsa.enable = true;
  services.pipewire.alsa.support32Bit = true;
  services.pipewire.pulse.enable = true;
}
