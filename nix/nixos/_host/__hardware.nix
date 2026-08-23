{ ... }@haumeaArgs: {
  notDetected = { modulesPath, ... }@nixosModuleArgs: {
    imports = [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];
  };
}
