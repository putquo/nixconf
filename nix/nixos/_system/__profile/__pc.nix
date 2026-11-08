{ inputs, ... }@haumeaArgs:
{ lib, pkgs, ... }@nixosModuleArgs: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
    inputs.stylix.nixosModules.stylix
  ];

  environment.systemPackages = [
    pkgs.curl
    pkgs.pciutils
    pkgs.usbutils
    pkgs.vim
    pkgs.wget
  ];

  fonts.packages = [
    pkgs.noto-fonts
    pkgs.noto-fonts-cjk-sans
    pkgs.noto-fonts-color-emoji
    pkgs.nerd-fonts.monaspace
  ];

  home-manager.backupFileExtension = "backup";
  home-manager.verbose = true;
  home-manager.sharedModules = [
    {
      options.tag = lib.mkOption {
        description = "A tag for additional metadata";
        type = lib.types.str;
      };
    }
  ];
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  i18n.defaultLocale = "en_US.UTF-8";

  networking.networkmanager.enable = true;
  networking.useDHCP = lib.mkDefault true;

  nix.gc.automatic = true;
  nix.gc.options = "--delete-older-than 7d";
  nix.optimise.automatic = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.warn-dirty = false;
  nix.settings.substituters = [
    "https://nix-community.cachix.org"
  ];
  nix.settings.trusted-public-keys = [
    "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
  ];
  nix.settings.trusted-users = [
    "@wheel"
  ];

  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [
    inputs.nur.overlays.default
    (final: prev: {
      _1password-gui = prev._1password-gui.overrideAttrs (prev: {
        postInstall = (prev.postInstall or "") + ''
          mkdir -p $out/etc/xdg/autostart
          cp $out/share/applications/com.onepassword.OnePassword.desktop $out/etc/xdg/autostart/com.onepassword.OnePassword.desktop
          substituteInPlace $out/etc/xdg/autostart/com.onepassword.OnePassword.desktop \
            --replace 'Exec=${prev.pname} %U' 'Exec=${prev.pname} --silent %U'
        '';
      });
    })
  ];

  programs._1password.enable = true;
  programs._1password-gui.enable = true;
  programs.fish.enable = true;

  security.pam.u2f.enable = true;
  security.pam.u2f.control = "sufficient";
  security.pam.u2f.settings.cue = true;

  services.fstrim.enable = true;
  services.fwupd.enable = true;
  services.smartd.enable = true;
  services.smartd.notifications.systembus-notify.enable = true;
  services.systembus-notify.enable = true;
  services.udev.extraRules = ''
    ACTION=="remove",\
     ENV{SUBSYSTEM}=="usb",\
     ENV{PRODUCT}=="1050/402/556",\
     RUN+="${pkgs.systemd}/bin/loginctl lock-sessions"
  '';
  services.tailscale.enable = true;

  stylix.enable = true;
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/dracula.yaml";
  stylix.cursor = {
    name = "Pop";
    package = pkgs.pop-icon-theme;
    size = 28;
  };
  stylix.fonts = {
    serif = {
      name = "Noto Serif";
      package = pkgs.noto-fonts;
    };

    sansSerif = {
      name = "Noto Sans";
      package = pkgs.noto-fonts;
    };

    monospace = {
      name = "MonaspiceNe Nerd Font Mono";
      package = pkgs.nerd-fonts.monaspace;
    };
  };
  stylix.image = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/aynp/dracula-wallpapers/refs/heads/main/Art/4k/Dracula.png";
    sha256 = "sha256-+kZN+QqB7AOjqJXvuNAhoPApbi5JR+cwtCgWOD8vJ4E=";
  };

  time.timeZone = "Europe/Amsterdam";

  zramSwap.enable = true;
}
