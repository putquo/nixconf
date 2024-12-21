{ cell, name, super, ... }@_haumeaArgs: {
  host = cell.host.${name};

  profiles = [
    super.profile.development
    super.profile.gnome
    super.profile.laptop
    # super.profile.wazuh
  ];

  users = [
    cell.user.toil
  ];
}
