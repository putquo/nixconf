{ super, ... }@haumeaArgs:
{ tag, username }@profileArgs:
{ pkgs, ... }@nixosModuleArgs: {

  home-manager.users.${username} = {
    inherit tag;
    imports = [
      super.profile.pc
    ];

    stylix.targets.gnome-text-editor.enable = false;
    stylix.targets.helix.enable = false;
    stylix.targets.rofi.enable = false;
  };

  programs._1password-gui.polkitPolicyOwners = [ username ];

  users.users.${username} = {
    description = tag;
    extraGroups = [ "docker" "networkmanager" "wheel" ];
    initialHashedPassword = "$y$j9T$UqE7JOa1lbox.5VeLiJOQ.$YO8HV4nd2HtMkj2GIEHdaymgYw3gmDtm4hxpYOFo6TA";
    isNormalUser = true;
    name = username;
    shell = pkgs.fish;
  };
}
