#!/usr/bin/env bash
set -euo pipefail

PACKAGES=(
  zsh
  mise
  starship
  tmux
  nvim
  agents
)

REMOVE_PACKAGES=(
  agents
  nvim
  tmux
  starship
  mise
  zsh
)

TARGET_DIR="${HOME}"

usage() {
  cat <<'EOF'
Usage: ./run.sh <command>

Commands:
  install           Install GNU Stow if needed, then stow all dotfiles into $HOME
  install-stow      Install GNU Stow using a supported package manager
  install-dotfiles  Stow all dotfile packages into $HOME
  rebuild           Re-stow all packages (rebuild symlinks)
  remove            Unstow all packages from $HOME
  dry-run           Preview what install-dotfiles would do
  help              Show this help
EOF
}

install_stow() {
  if command -v stow >/dev/null 2>&1; then
    echo "stow is already installed"
    return 0
  fi

  if command -v brew >/dev/null 2>&1; then
    brew install stow
  elif command -v apt-get >/dev/null 2>&1; then
    sudo apt-get update
    sudo apt-get install -y stow
  elif command -v dnf >/dev/null 2>&1; then
    sudo dnf install -y stow
  elif command -v yay >/dev/null 2>&1; then
    yay -Sy --noconfirm stow
  elif command -v pacman >/dev/null 2>&1; then
    sudo pacman -Sy --noconfirm stow
  else
    echo "Could not find a supported package manager to install stow"
    echo "Please install GNU Stow manually and rerun this script"
    exit 1
  fi
}

ensure_stow() {
  if ! command -v stow >/dev/null 2>&1; then
    echo "stow is not installed"
    echo "Run: ./run.sh install-stow"
    exit 1
  fi
}

run_stow() {
  local mode="$1"
  shift
  local packages=("$@")

  ensure_stow

  echo "Target: ${TARGET_DIR}"
  echo "Packages: ${packages[*]}"

  if [[ -n "$mode" ]]; then
    stow "$mode" -v -t "${TARGET_DIR}" "${packages[@]}"
  else
    stow -v -t "${TARGET_DIR}" "${packages[@]}"
  fi
}

case "${1:-help}" in
  install)
    install_stow
    run_stow "" "${PACKAGES[@]}"
    ;;
  install-stow)
    install_stow
    ;;
  install-dotfiles)
    run_stow "" "${PACKAGES[@]}"
    ;;
  rebuild)
    run_stow "-R" "${PACKAGES[@]}"
    ;;
  remove)
    run_stow "-D" "${REMOVE_PACKAGES[@]}"
    ;;
  dry-run)
    run_stow "-n" "${PACKAGES[@]}"
    ;;
  help|--help|-h)
    usage
    ;;
  *)
    echo "Unknown command: ${1}"
    echo
    usage
    exit 1
    ;;
esac
