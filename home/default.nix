# https://github.com/srid/nixos-config/blob/master/home/default.nix
{ self, inputs, ... }:
{
  flake = {
    homeModules = {
      common = {
        # home.stateVersion = "22.11";
        home.stateVersion = "24.05";
        imports = [
          # inputs.nixvim.homeManagerModules.nixvim
          inputs.nix-index-database.hmModules.nix-index
          ./main.nix
          ./direnv.nix
          ./git.nix
          ./starship.nix
          ./tmux.nix
        ];
      };
      common-linux = {
        imports = [
          self.homeModules.common
          ./bash.nix
          ./zsh.nix
        ];
      };
      common-darwin = {
        imports = [
          self.homeModules.common
          ./zsh.nix
          ./bash.nix
          # ./_1password.nix
        ];
      };
    };
  };
}
