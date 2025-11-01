{ name, super, ... }@_haumeaArgs:
{ config, pkgs, ... }@_nixosModuleArgs: {
  imports = [
    # Remove some boilerplate
    (super.pc-user {
      tag = "Work";
      username = name;
    })
  ];

  home-manager.users.${name} = {
    imports = [
      super.profile.development
    ];

    home.packages = with pkgs; [
      gnumake
      google-cloud-sdk
      jetbrains.idea-community-bin
      kubectl
      kubectx
      kubelogin-oidc
      slack
      sops
      yaml-language-server

      (wrapHelm kubernetes-helm {
        plugins = [
          kubernetes-helmPlugins.helm-secrets
        ];
      })
    ];

    programs.git.settings.user.signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK4z+GCnpEmPq2uRl1Ol8a83Xjmeiqk1q8XV3cZh7pWZ";

    programs.jujutsu.settings.signing.key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK4z+GCnpEmPq2uRl1Ol8a83Xjmeiqk1q8XV3cZh7pWZ";

    programs.java.enable = true;
    programs.java.package = pkgs.jdk17;

    programs.k9s.enable = true;
    programs.k9s.settings = {
      k9s = {
        shellPod = {
          image = "nixos/nix";
          namespace = "default";
          limits = {
            cpu = "100m";
            memory = "200Mi";
          };
        };
        thresholds = {
          cpu = {
            critical = 90;
            warn = 70;
          };
          memory = {
            critical = 90;
            warn = 85;
          };
        };
        ui = {
          logoless = true;
          reactive = true;
        };
      };
    };

    xdg.configFile."Yubico/u2f_keys".text =
      "toil:WMbAX+1VyShI4C+vVKKhkeFcVUz+mbQT0v4flDZHCVSO02rYQC47EoG6PreqThG9Wjgut5CFSPLT9/+E/GuIFQ=="
      + ",M8Li+xgy7bhNqXeuNmyAZFNX70W+RhgbQ4piZTMWSrD9ANdgL+CGWDSWj7Moxgyrs+ArzceZ04i+gEKTy77oqw==,es256,+presence"
      + ":LqQyzxoluRwdLiVchvSpkW0Tw+16UY1qFx85DcYWW4FuK+AEiKMWtctTZnyGzLcaFirNK5Et4HkLPvh91UkRyw=="
      + ",P+ikZBs2dfg9zX+OE9+LpsaC1TCdul1Ny6O5bdjgwsuDjj/btgphW0fgY0MXKAh2hF4Cm0c6rw5RjzXpriKn0w==,es256,+presence";
  };

  programs.openvpn3.enable = true;

  services.udev.packages = [
    pkgs.android-udev-rules
  ];

  systemd.services.openvpn = {
    description = "OpenVPN";
    after = [ "dbus.service" "network-online.target" ];
    wants = [ "dbus.service" "network-online.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig =
      let
        openvpn3-systemd = "${pkgs.openvpn3}/libexec/openvpn3-linux/openvpn3-systemd";
      in
      {
        Type = "notify";
        PrivateTmp = true;
        ProtectSystem = true;
        ProtectHome = true;
        Environment = "PYTHONUNBUFFERED=on";
        ExecStart = "${openvpn3-systemd} --start formelio";
        ExecReload = "${openvpn3-systemd} --restart formelio";
        ExecStop = "${openvpn3-systemd} --stop formelio";
      };
  };

  systemd.services.wazuh = {
    description = "Sets up wazuh container";
    after = [ "network.target" "network-online.target" ];
    wants = [ "network.target" "network-online.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStart = "systemd-nspawn --keep-unit --boot -D /var/lib/machines/byte";
    };
  };

  systemd.targets.multi-user.wants = [ "openvpn.service" "wazuh.service" ];
}
