{ inputs, ... }@haumeaArgs: {
  "x86_64-linux".default = inputs.devenv.lib.mkShell
    {
      inherit inputs;
      pkgs = inputs.nixpkgs.legacyPackages."x86_64-linux";
      modules = [
        ({ pkgs, ... }: {
          languages.nix.enable = true;
          packages = [
            pkgs.nixpkgs-fmt
          ];
        })
      ];
    };
}
