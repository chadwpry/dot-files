export BUN_INSTALL="$HOME/.bun"
export EDITOR="nvim"
export LIBPQ_INSTALL="/opt/homebrew/opt/libpq/bin"

export PATH="$LIBPQ_INSTALL:$BUN_INSTALL:$PATH"

eval "$(~/.local/bin/mise activate zsh)"

source <(fzf --zsh)
