export BUN_INSTALL="$HOME/.bun"
export EDITOR="nvim"
export PATH="$BUN_INSTALL/bin:$PATH"

eval "$(~/.local/bin/mise activate zsh)"

source <(fzf --zsh)
