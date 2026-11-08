{ name, super, ... }@haumeaArgs:
{ ... }@nixosModuleArgs:
{
  imports = [
    (super.pc-user {
      tag = "Personal";
      username = name;
    })
  ];

  home-manager.users.${name} = {
    imports = [
      super.profile.development
      super.profile.gaming
    ];

    xdg.configFile."Yubico/u2f_keys".text =
      "putquo:YRyD9p+nEgdTnj6DefvG2pey7mVGn931NnfmyRhhU6ObaPRPF+RYDRH0YXU1go0r4XClZpubnXUSAA2soUfiDg=="
      + ",onnVg36QcW0RSU7ij+mIOjvVm71KrAOZ2/Y1k0kL/6sFD1ggWAa4NvWv4ZOyRc1MfXEmY6+qFNaUJRMTbab/EQ=="
      + ",es256,+presence:UKD6uA7TxPZxHlX5CNlSkXfNcncOJ9O6XGWVcEDpftYzY0gaqaWknCc193a0j7tuzBUN3JUKQVxjURUaC3UkrQ=="
      + ",3LkMS/SIv0WD7l/L/Og0Bj6tWxrLDbfTtR9V+0RUwADaXWNFbzvVfM5KzaWWviOT/fVcZoN+9ibXwuMGrRmzsw==,es256,+presence";
  };
}
