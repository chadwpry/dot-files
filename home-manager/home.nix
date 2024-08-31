{ config, pkgs, ... }:
  let
    gitUser = builtins.getEnv "GITUSER";
    gitEmail = builtins.getEnv "GITEMAIL";
    userName = builtins.getEnv "USER";
    homeDirectory = builtins.getEnv "HOME";
    # isDarwin = system == "aarch64-darwin" || system == "x86_64-darwin";
  in {
    # Home Manager needs a bit of information about you and the
    # paths it should manage.
    home.username = "${userName}";
    home.homeDirectory = "${homeDirectory}";

    # Packages that should be installed to the user profile.
    home.packages = with pkgs; [
      pkgs.age
      pkgs.azure-cli
      pkgs.cmake
      pkgs.docker-compose
      pkgs.ffmpeg
      pkgs.fortune
      pkgs.glib
      pkgs.gnupg
      pkgs.gpgme
      pkgs.htop
      pkgs.jq
      pkgs.libiconv
      pkgs.nb
      pkgs.neovim
      pkgs.openssl
      pkgs.openssl.dev
      pkgs.pkg-config
      pkgs.readline
      pkgs.ripgrep
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

    programs.direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };

    programs.git = {
      enable = true;
      # userName = "Chad W Pry";
      # userEmail = "chad.pry@gmail.com";
      userName = "${gitUser}";
      userEmail = "${gitEmail}";
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
        credential = {
          helper = "store";
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

    programs.starship = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        add_newline = false;
      };
    };

    programs.tmux = {
      enable = true;
      aggressiveResize = true;
      baseIndex = 1;
      historyLimit = 50000;
      keyMode = "vi";
      mouse = true;
      plugins = with pkgs; [
        {
          plugin = tmuxPlugins.dracula;
          extraConfig = ''
            set -g @plugin 'dracula/tmux'
            set -g @dracula-theme 'default'
            set -g @dracula-time-format "%a %F %R %Z"
            set -g @dracula-show-powerline true
            set -g @dracula-plugins "git ssh-session time"
            set -g @dracula-git-colors "dark_gray green"
            set -g @dracula-ssh-session-colors "dark_gray pink"
            set -g @dracula-time-colors "dark_gray white"
            set -g @dracula-show-left-icon '⮕'
            set -g @dracula-left-icon-padding 0
          '';
        }
        tmuxPlugins.sensible
        tmuxPlugins.yank
      ];
      prefix = "C-b";
      shell = "${pkgs.zsh}/bin/zsh";
      terminal = "tmux-256color";
        # if isDarwin
        # then "screen-256color"
        # else "xterm-256color";
      extraConfig = ''
        set-option -g renumber-windows on

        set-option -a terminal-overrides ",*256col*:RGB"
        set-window-option -g pane-base-index 1

        # load configuration
        bind-key r source-file ~/.config/tmux/tmux.conf \; display-message "~/.config/tmux/tmux.conf reloaded"
        bind-key M split-window -h "nvim ~/.config/tmux/tmux.conf"

        # nvim
        bind-key v split-window -h -c "#{pane_current_path}"
        bind-key s split-window -v -c "#{pane_current_path}"

        # setw -g history-limit 50000

        set-option -g status-position top

        # buffer select and yank
        bind-key -T copy-mode-vi v send -X begin-selection
        bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
        bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel

        # clear screen without tmux prefix key
        bind-key -n C-l send-keys 'C-l'

        # set pane change bindings for tmux
        bind-key C-h select-pane -L
        bind-key C-l select-pane -R
        bind-key C-k select-pane -U
        bind-key C-j select-pane -D

        bind-key -n M-0 resize-pane -Z

        bind-key -n M-Up resize-pane -U 2
        bind-key -n M-Right resize-pane -R 2
        bind-key -n M-Down resize-pane -D 2
        bind-key -n M-Left resize-pane -L 2
      '';
    };

    programs.zsh = {
      autosuggestion.enable = true;
      enable = true;
      enableCompletion = true;
      history = {
        size = 10000;
        path = "${config.xdg.dataHome}/zsh/history";
      };
      sessionVariables = {
        EDITOR = "nvim";
        PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
        PROMPT = "%F{green}%*%f %F{cyan}%~%f %F{red}%f$ ";
        GITUSER = "${gitUser}";
        GITEMAIL = "${gitEmail}";
      };
      shellAliases = {
        ls = "ls --color=auto";
      };
      syntaxHighlighting.enable = true;
      zplug = {
        enable = true;
        plugins = [
          { name = "zsh-users/zsh-autosuggestions"; }
        ];
      };

      initExtra = ''
        echo -ne '\033]0;New Window\a'

        settitle() {
          echo -ne '\033]0;'"$1"'\a'
        }
      '';
    };

    # services.gpg-agent = {
    #   enable = true;
    #   defaultCacheTtl = 1800;
    #   enableSshSupport = true;
    # };
  }
