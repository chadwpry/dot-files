# https://github.com/srid/nixos-config/blob/master/home/default.nix
{ self, inputs, ... }:
{
  flake = {
    homeModules = {
      common-linux = {
        home.stateVersion = "24.05";

        imports = [
          ./main.nix
          ./direnv.nix
          ./git.nix
          ./starship.nix
          ./tmux.nix

          ./bash.nix
          ./zsh.nix
        ];
      };
      common-darwin = {
        home.stateVersion = "24.05";

        imports = [
          ./main.nix
          ./direnv.nix
          ./git.nix
          ./starship.nix
          ./tmux.nix

          ./zsh.nix
          ./bash.nix
          # ./_1password.nix
        ];
      };
    };
  };
}
