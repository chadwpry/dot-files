{ config, pkgs, lib, ... }:

{
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
      set-window-option -g mode-keys vi

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
}

