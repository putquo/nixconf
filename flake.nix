{
  description = "Nix-based system configuration";

  inputs = {
    devenv.url = "github:cachix/devenv";
    devenv.inputs.flake-compat.follows = "flake-compat";
    devenv.inputs.flake-parts.follows = "flake-parts";
    devenv.inputs.nixpkgs.follows = "nixpkgs";

    flake-compat.url = "github:nixos/flake-compat";
    flake-compat.flake = false;

    flake-parts.url = "github:hercules-ci/flake-parts";

    haumea.url = "github:nix-community/haumea";
    haumea.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nur.url = "github:nix-community/nur";
    nur.inputs.flake-parts.follows = "flake-parts";
    nur.inputs.nixpkgs.follows = "nixpkgs";

    stylix.url = "github:danth/stylix";
    stylix.inputs.flake-parts.follows = "flake-parts";
    stylix.inputs.nixpkgs.follows = "nixpkgs";
    stylix.inputs.nur.follows = "nur";
  };

  outputs = { haumea, nixpkgs, ... }@inputs:
    let
      lib = haumea.lib.load {
        inherit loader;
        inputs = { inherit inputs; };
        src = ./nix;
      };

      loader =
        let
          named.matches = name:
            nixpkgs.lib.hasSuffix ".nix" name;
          named.loader = loaderInputs: path:
            haumea.lib.loaders.default
              (loaderInputs // { name = filenameFrom path; })
              path;
          filenameFrom = path:
            nixpkgs.lib.lists.last
              (nixpkgs.lib.strings.splitString "/" (removeNixExtensionFrom path));
          removeNixExtensionFrom = path:
            nixpkgs.lib.removeSuffix ".nix" (toString path);
        in
        [ named ];
    in
    {
      devShells = lib.shells.development;
      nixosConfigurations = lib.nixos.systems;
    };
}
