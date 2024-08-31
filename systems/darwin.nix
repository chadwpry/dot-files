{ flake, ... }:

let
  inherit (flake) inputs;
  inherit (inputs) self;
in
{
  imports = [
    self.darwinModules.default
    "${self}/nix-darwin/zsh-completion-fix.nix"
    # "${self}/nixos/github-runner.nix"
  ];

  nixpkgs.hostPlatform = "aarch64-darwin";
  # networking.hostName = "bass";

  security.pam.enableSudoTouchIdAuth = true;

  # For home-manager to work.
  # users.users."${flake.config.people.myself}" = {
  #   name = flake.config.people.myself;
  #   home = "/Users/${flake.config.people.myself}";
  # };
  users.users.shadow = {
    name = "shadow";
    home = "/Users/shadow";
  };

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  # system.keyboard.enableKeyMapping = true;
  # system.keyboard.remapCapsLockToControl = true;

  # system.activationScripts.postUserActivation.text = ''
  #   # Following line should allow us to avoid a logout/login cycle
  #   /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
  # '';

  system.defaults = {
    # Show file extensions in Finder
    finder.AppleShowAllExtensions = true;

    # Default to column view in Finder
    finder.FXPreferredViewStyle = "clmv";

    # Allow quitting Finder from the menu
    finder.QuitMenuItem = true;

    finder.ShowPathbar = true;
    finder.ShowStatusBar = true;

    # Disable guest logins
    loginwindow.GuestEnabled = false;

    # Switch light/dark style of OS automatically based on time
    NSGlobalDomain.AppleInterfaceStyleSwitchesAutomatically = true;
  };
}
