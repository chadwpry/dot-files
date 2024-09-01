{ flake, config, pkgs, ... }:
  let
    userName = "${flake.config.people.myself}";
    homeDirectory = "/Users/${flake.config.people.myself}";
    # isDarwin = system == "aarch64-darwin" || system == "x86_64-darwin";
  in {
    # Home Manager needs a bit of information about you and the
    # paths it should manage.
    home.username = "${userName}";
    home.homeDirectory = "${homeDirectory}";

    # Packages that should be installed to the user profile.
    home.packages = with pkgs; [
      pkgs.azure-cli
      pkgs.cmake
      pkgs.docker-compose
      pkgs.ffmpeg
      pkgs.fortune
      pkgs.glib
      pkgs.gnupg
      pkgs.gpgme
      pkgs.libiconv
      pkgs.nb
      pkgs.neofetch
      pkgs.neovim
      pkgs.nerdfonts
      # pkgs.openssl
      # pkgs.openssl.dev
      # pkgs.pkg-config
      pkgs.rustup
      pkgs.streamlink
      pkgs.tree
      pkgs.w3m
      pkgs.watch
      pkgs.watchman
      pkgs.websocat
      pkgs.weechat
    ];

    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    home.stateVersion = "24.05";

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;

    programs.awscli = {
      enable = true;
    };

    programs.bat = {
      enable = true;
    };

    programs.fastfetch = {
      enable = true;
    };

    programs.go = {
      enable = true;
    };

    programs.htop = {
      enable = true;
    };

    programs.jq = {
      enable = true;
    };

    programs.less = {
      enable = true;
    };

    programs.lesspipe = {
      enable = true;
    };

    programs.pandoc = {
      enable = true;
    };

    programs.readline = {
      enable = true;
    };

    programs.ripgrep = {
      enable = true;
    };

    # services.gpg-agent = {
    #   enable = true;
    #   defaultCacheTtl = 1800;
    #   enableSshSupport = true;
    # };
  }
