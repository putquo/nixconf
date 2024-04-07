{ config, lib, pkgs, ... }: with lib; let
  wsl = config.wsl.enable;
in {
  options = {
    presets.system.base.enable = mkOption {
      type = types.bool;
      description = "Whether to enable the base system preset.";
      default = true;
      example = true;
    };
  };

  config = mkIf config.presets.system.base.enable {
    environment.systemPackages = with pkgs; [
      curl
      fzf
      git
      go
      jellyfin-web
      jq
      libgccjit
      lua
      nodejs_latest
      protonvpn-gui
      ripgrep
      tailscale
      tree
      unzip
      vim
      wireguard-tools
      wget
      which
      zip
    ];

    fonts.packages = with pkgs; [
      (nerdfonts.override { fonts = [ "CascadiaCode" "JetBrainsMono" ]; })
    ];

    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;

    programs._1password-gui.enable = mkIf (!wsl) true;

    nix.extraOptions = "warn-dirty = false";
    nix.gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 1w";
    };
    nix.settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
    };

    nixpkgs.config.allowUnfree = true;

    services.tailscale.enable = true;

    services.xserver.desktopManager.xterm.enable = false;
    services.xserver.excludePackages = [ pkgs.xterm ];

    systemd.services.docker-desktop-proxy.script = mkForce ''${config.wsl.wslConf.automount.root}/wsl/docker-desktop/docker-desktop-user-distro proxy --docker-desktop-root ${config.wsl.wslConf.automount.root}/wsl/docker-desktop "C:\Program Files\Docker\Docker\resources"'';

    virtualisation = {
      docker = {
        enable = true;
        enableOnBoot = true;
        autoPrune.enable = true;
      };

      podman = mkIf (!wsl) {
        enable = true;
        defaultNetwork.settings.dns_enabled = true;
      };
    };

    wsl.extraBin = with pkgs; [
      { src = "${coreutils}/bin/mkdir"; }
      { src = "${coreutils}/bin/cat"; }
      { src = "${coreutils}/bin/whoami"; }
      { src = "${coreutils}/bin/ls"; }
      { src = "${busybox}/bin/addgroup"; }
      { src = "${su}/bin/groupadd"; }
      { src = "${su}/bin/usermod"; }
    ];
  };
}
