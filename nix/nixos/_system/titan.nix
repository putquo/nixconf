{ name, root, super, ... }@haumeaArgs: {
  host = root.nixos.host.${name};

  profiles = [
    super.profile.cosmic
    super.profile.desktop
    super.profile.development
    super.profile.gaming
    super.profile.wayland
  ];

  users = [
    root.nixos.user.putquo
  ];
}
