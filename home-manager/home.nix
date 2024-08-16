{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = builtins.getEnv "USER";
  home.homeDirectory = builtins.getEnv "HOME";

  # Packages that should be installed to the user profile.
  home.packages = [
    pkgs.awscli
    pkgs.azure-cli
    pkgs.cmake
    pkgs.docker-compose
    pkgs.ffmpeg
    pkgs.fortune
    pkgs.git
    pkgs.glib
    pkgs.gnupg
    pkgs.go
    pkgs.gpgme
    pkgs.htop
    pkgs.jq
    pkgs.libiconv
    pkgs.neovim
    pkgs.openssl
    pkgs.openssl.dev
    pkgs.pkg-config
    pkgs.pulumi
    pkgs.readline
    pkgs.redis
    pkgs.ripgrep
    pkgs.rustup
    pkgs.taskwarrior
    pkgs.tmux
    pkgs.tree
    pkgs.twitch-cli
    pkgs.watch
    pkgs.watchman
    pkgs.websocat
    pkgs.weechat
    pkgs.zsh
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

  programs.git = {
    enable = true;
    # userName = "Chad W Pry";
    # userEmail = "chad.pry@gmail.com";
    userName = builtins.getEnv "GITUSER";
    userEmail = builtins.getEnv "GITEMAIL";
    aliases = {
      st = "status";
      ci = "commit";
      br = "branch";
      co = "checkout";
      df = "diff";
      lg = "log -p";
    };
    extraConfig = {
      color = {
        branch = {
          current = "yellow reverse";
          local = "yellow";
          remote = "green";
        };
        diff = {
          frag = "magenta bold";
          meta = "yellow bold";
          new = "green bold";
          old = "red bold";
          whitespace = "red reverse";
        };
        status = {
          added = "yellow";
          changed = "green";
          untracked = "cyan";
        };
        ui = "auto";
      };
      core = {
        autocrlf = false;
        whitespace = "fix,-indent-with-non-tab,trailing-space,cr-at-eol";
        editor = "nvim";
      };
      filter= {
        lfs = {
          required = true;
          clean = "git-lfs clean -- %f";
          smudge = "git-lfs smudge -- %f";
          process = "git-lfs filter-process";
        };
      };
      http = {
        sslVerify = false;
      };
      init = {
        defaultBranch = "main";
      };
      lfs.enable = true;
      mergetool = {
        diffmerge = {
          cmd = "diffmerge --merge --result=$MERGED $LOCAL $BASE $REMOTE";
          trustExitCode = false;
        };
      };
      pager = {
        branch = false;
      };
    };
  };

  programs.go = {
    enable = true;
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    shellAliases = {
      ls = "ls --color=auto";
    };
    syntaxHighlighting.enable = true;
    sessionVariables = {
      EDITOR = "nvim";
      PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
      PROMPT="%F{green}%*%f %F{cyan}%~%f %F{red}%f$ ";
    };
    zplug = {
      enable = true;
      plugins = [
        { name = "zsh-users/zsh-autosuggestions"; }
      ];
    };

    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };

    initExtra = ''
      for config_file in $(ls $HOME/.config/zsh | grep -e '.zsh$')
      do
        source "$HOME/.config/zsh/$config_file"
      done
    '';
  };

  # services.gpg-agent = {
  #   enable = true;
  #   defaultCacheTtl = 1800;
  #   enableSshSupport = true;
  # };
}
