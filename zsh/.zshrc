export APPLICATIONS_INSTALL="$HOME/Applications"
export BUN_INSTALL="$HOME/.bun"
export EDITOR="nvim"
export XDG_CONFIG_HOME="$HOME/.config"

export PATH="$BUN_INSTALL:$APPLICATIONS_INSTALL:$PATH"

autoload -Uz compinit
compinit

compdef _make make

if command -v mise >/dev/null 2>&1; then
  eval "$(mise activate zsh)"
elif [[ -x "$HOME/.local/bin/mise" ]]; then
  eval "$("$HOME/.local/bin/mise" activate zsh)"
fi

if command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
fi

if command -v fzf >/dev/null 2>&1; then
  source <(fzf --zsh)
fi

if [[ -r "$HOME/.config/zsh/podman-docker.zsh" ]]; then
  source "$HOME/.config/zsh/podman-docker.zsh"
fi

# Added by dbt installer
export PATH="$PATH:/Users/cpry/.local/bin"

# dbt aliases
alias dbtf=/Users/cpry/.local/bin/dbt

# Pi
export PATH="/Users/cpry/.local/share/mise/installs/node/26.7.0/bin:$PATH"
