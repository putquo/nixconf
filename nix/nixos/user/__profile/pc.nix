{ ... }@_haumeaArgs:
{ config, lib, osConfig, pkgs, ... }@_hmModuleArgs: {
  home.stateVersion = osConfig.system.stateVersion;

  programs.alacritty.enable = true;
  programs.alacritty.settings = {
    window.decorations = "None";
    window.dynamic_padding = true;
    window.padding.x = 8;
  };

  programs.btop.enable = true;

  programs.firefox.enable = true;
  programs.firefox.package = pkgs.firefox-bin;
  programs.firefox.profiles.default = {
    id = 0;
    name = "default";
    isDefault = true;
    extensions = with pkgs.nur.repos.rycee.firefox-addons; [
      onepassword-password-manager
      ublock-origin
    ];
  };

  programs.fish.enable = true;
  programs.fish.interactiveShellInit = ''
    set fish_greeting
    fish_vi_key_bindings
  '';

  programs.home-manager.enable = true;

  xdg.configFile."Yubico/u2f_keys".text =
    "preston:YRyD9p+nEgdTnj6DefvG2pey7mVGn931NnfmyRhhU6ObaPRPF+RYDRH0YXU1go0r4XClZpubnXUSAA2soUfiDg=="
    + ",onnVg36QcW0RSU7ij+mIOjvVm71KrAOZ2/Y1k0kL/6sFD1ggWAa4NvWv4ZOyRc1MfXEmY6+qFNaUJRMTbab/EQ=="
    + ",es256,+presence:UKD6uA7TxPZxHlX5CNlSkXfNcncOJ9O6XGWVcEDpftYzY0gaqaWknCc193a0j7tuzBUN3JUKQVxjURUaC3UkrQ=="
    + ",3LkMS/SIv0WD7l/L/Og0Bj6tWxrLDbfTtR9V+0RUwADaXWNFbzvVfM5KzaWWviOT/fVcZoN+9ibXwuMGrRmzsw==,es256,+presence";

  xdg.userDirs.enable = true;
  xdg.userDirs.createDirectories = true;
  xdg.userDirs.desktop = "$HOME/desktop";
  xdg.userDirs.documents = "$HOME/documents";
  xdg.userDirs.download = "$HOME/downloads";
  xdg.userDirs.music = "$HOME/media/music";
  xdg.userDirs.pictures = "$HOME/media/images";
  xdg.userDirs.publicShare = "$HOME/public";
  xdg.userDirs.videos = "$HOME/media/videos";
  xdg.userDirs.templates = "$HOME/templates";
}
