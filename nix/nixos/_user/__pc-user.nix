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
  };

  programs._1password-gui.polkitPolicyOwners = [ username ];

  users.users.${username} = {
    description = tag;
    extraGroups = [ "docker" "networkmanager" "wheel" ];
    initialPassword = "initPass";
    isNormalUser = true;
    name = username;
    shell = pkgs.fish;
  };
}
