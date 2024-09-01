{ self, inputs, config, ... }:

{
  # Configuration common to all Linux systems
  flake = {
    nixosModules = {
      # NixOS modules that are known to work on nix-darwin.
      common.imports = [
        ./nix.nix
        # ./caches
        # ./self/primary-as-admin.nix
      ];

      my-home = {
        users.users."observable".isNormalUser = true;
        home-manager.users."observable" = {
          imports = [
            self.homeModules.common-linux
          ];
        };
      };

      default.imports = [
        self.nixosModules.home-manager
        self.nixosModules.my-home
        self.nixosModules.common
        # ./self/self-ide.nix
        # ./current-location.nix
      ];
    };
  };
}