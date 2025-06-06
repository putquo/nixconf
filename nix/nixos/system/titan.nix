{ cell, name, super, ... }@_haumeaArgs: {
  host = cell.host.${name};

  profiles = [
    super.profile.cosmic
    super.profile.desktop
    super.profile.development
    super.profile.gaming
    super.profile.wayland
  ];

  users = [
    cell.user.putquo
  ];
}
