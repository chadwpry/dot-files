{
  description = "NixOS / nix-darwin configuration";

  inputs = {
    # Principle inputs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    # nixos-hardware.url = "github:NixOS/nixos-hardware";
    nixos-flake.url = "github:srid/nixos-flake";
    # disko.url = "github:nix-community/disko";
    # disko.inputs.nixpkgs.follows = "nixpkgs";
    # ragenix.url = "github:yaxitech/ragenix";
    # nuenv.url = "github:hallettj/nuenv/writeShellApplication";

    # Software inputs
    # github-nix-ci.url = "github:juspay/github-nix-ci";
    # nixos-vscode-server.flake = false;
    # nixos-vscode-server.url = "github:nix-community/nixos-vscode-server";
    # nix-index-database.url = "github:nix-community/nix-index-database";
    # nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
    # actualism-app.url = "github:srid/actualism-app";
    # omnix.url = "github:juspay/omnix";

    # Neovim
    # nixvim.url = "github:nix-community/nixvim";
    # nixvim.inputs.nixpkgs.follows = "nixpkgs";

    # Devshell
    # treefmt-nix.url = "github:numtide/treefmt-nix";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nixos-wsl, home-manager, ... }:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      imports = [
        inputs.nixos-flake.flakeModule
        # inputs.treefmt-nix.flakeModule
        ./users
        ./home
        # ./nixos
        ./nix-darwin
      ];


      flake = {
        # Configuration for my M1 Macbook Max (using nix-darwin)
        darwinConfigurations.bass =
          self.nixos-flake.lib.mkMacosSystem
            ./systems/darwin.nix;

        nixosConfigurations = {
          nixos = self.nixos-flake.lib.mkLinuxSystem {
            nixpkgs.hostPlatform = "x86_64-linux";
            imports = [
              self.nixosModules.common
              self.nixosModules.linux
              self.nixosModules.home-manager
              {
                home-manager.users.shadow = {
                  imports = [
                    self.homeModules.common
                    self.homeModules.linux
                  ];
                  wsl.enable = true;
                };
              }
            ];
          };
        };

        nixosModules = {
          common = { pkgs, ... }: {
            environment.systemPackages = with pkgs; [

            ];
          };

          linux = { pkgs, ... }: {
            users.users.shadow.isNormalUser = true;
            # services.netdata.enable = true;
          };

          # darwin = { pkgs, ... }: {
          #   security.pam.enableSudoTouchIdAuth = true;
          # };
        };

        homeModules = import ./home;

        # nixosConfiguration."DESKTOP-72MFM9K" =
        #   self.nixos-flake.lib.mkLinuxSystem
        #     ./systems/wsl-ubuntu.nix;

        # Hetzner dedicated
        # nixosConfigurations.immediacy =
        #   self.nixos-flake.lib.mkLinuxSystem
        #     ./systems/ax41.nix;
      };

      perSystem = { self', inputs', pkgs, system, config, ... }: {
        # legacyPackages.homeConfigurations."shadow@ubuntu" =
        #   self.nixos-flake.lib.mkHomeConfiguration pkgs {
        #     imports = [
        #       self.homeModules.common-linux
        #     ];
        #     home.username = "shadow";
        #     home.homeDirectory = "/home/shadow";
        #   };

      #   # Flake inputs we want to update periodically
      #   # Run: `nix run .#update`.
        nixos-flake = {
          primary-inputs = [
            "nixpkgs"
            "home-manager"
            "nix-darwin"
            "nixos-flake"
            # "nix-index-database"
            # "nixvim"
          ];
        };

        # treefmt.config = {
        #   projectRootFile = "flake.nix";
        #   programs.nixpkgs-fmt.enable = true;
        # };

        packages.default = self'.packages.activate;

        # devShells.default = pkgs.mkShell {
        #   meta.description = "Dev environment for nixos-config";
        #   inputsFrom = [ config.treefmt.build.devShell ];
        #   packages = with pkgs; [
        #     just
        #     colmena
        #     nixd
        #     inputs'.ragenix.packages.default
        #   ];
        # };
        # # Make our overlay available to the devShell
        # _module.args.pkgs = import inputs.nixpkgs {
        #   inherit system;
        #   overlays = [
        #     inputs.nuenv.overlays.default
        #     (import ./packages/overlay.nix { inherit system; flake = { inherit inputs; }; })
        #   ];
        # };
      };
    };
}
