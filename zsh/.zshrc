export BUN_INSTALL="$HOME/.bun"
export EDITOR="nvim"
export LIBPQ_INSTALL="/opt/homebrew/opt/libpq/bin"

export PATH="$LIBPQ_INSTALL:$BUN_INSTALL:$PATH"

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
