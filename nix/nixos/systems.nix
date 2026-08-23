{ inputs, super, ... }@haumeaArgs:
let
  buildSystem = system: config:
    inputs.nixpkgs.lib.nixosSystem {
      modules = [ config.host ] ++ config.profiles ++ config.users;
    };
in
inputs.nixpkgs.lib.attrsets.mapAttrs
  buildSystem
  super.system
