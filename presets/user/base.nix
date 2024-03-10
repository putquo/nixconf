{ config, lib, osConfig, pkgs, wsl, ... }: with lib; {
  options = {
    presets.user.base.enable = mkOption {
      type = types.bool;
      description = "Whether to enable the base user preset.";
      default = true;
      example = true;
    };
  };

  config = mkIf config.presets.user.base.enable {
    home.packages = with pkgs; [
      fzf
      jq
      ripgrep
      tree
      which
      zip
    ];
    home.stateVersion = osConfig.system.stateVersion;

    programs = {
      firefox.enable = mkIf (!wsl) true;
      firefox.profiles.default = {
        id = 0;
        name = "default";
        isDefault = true;
        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
          onepassword-password-manager
          ublock-origin
        ];
      };

      fish.enable = true;
      fish.interactiveShellInit = ''
        set fish_greeting
        fish_vi_key_bindings
      '';

      home-manager.enable = true;
    };

    xdg.userDirs = {
      enable = true;
      createDirectories = true;
      desktop = "$HOME/desktop";
      documents = "$HOME/documents";
      download = "$HOME/downloads";
      music = "$HOME/media/music";
      pictures = "$HOME/media/images";
      publicShare = "$HOME/other/public";
      videos = "$HOME/media/videos";
      templates = "$HOME/other/templates";
      
      extraConfig = { XDG_DEV_DIR = "$HOME/workspace"; };
    };
  };
}
