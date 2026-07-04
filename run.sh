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
  install           Install GNU Stow if needed, stow dotfiles, then install tmux TPM/plugins
  install-stow      Install GNU Stow using a supported package manager
  install-dotfiles  Stow all dotfile packages into $HOME
  install-tmux-tpm  Clone TPM into the tmux package and install tmux plugins from tmux.conf
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

ensure_command() {
  local command_name="$1"
  local install_hint="$2"

  if ! command -v "${command_name}" >/dev/null 2>&1; then
    echo "${command_name} is not installed"
    echo "${install_hint}"
    exit 1
  fi
}

install_tmux_tpm() {
  local repo_plugins_dir="tmux/.config/tmux/plugins"
  local repo_tpm_dir="${repo_plugins_dir}/tpm"
  local home_tmux_conf="${HOME}/.config/tmux/tmux.conf"
  local home_tpm_install="${HOME}/.config/tmux/plugins/tpm/bin/install_plugins"

  ensure_command git "Please install git and rerun this script"
  ensure_command tmux "Please install tmux and rerun this script"

  mkdir -p "${repo_plugins_dir}"

  if [[ -d "${repo_tpm_dir}/.git" ]]; then
    echo "TPM is already cloned at ${repo_tpm_dir}"
  elif [[ -e "${repo_tpm_dir}" ]]; then
    echo "${repo_tpm_dir} already exists but is not a TPM git clone"
    echo "Remove it or move it aside, then rerun this script"
    exit 1
  else
    git clone https://github.com/tmux-plugins/tpm tmux/.config/tmux/plugins/tpm
  fi

  run_stow "" tmux

  if [[ ! -f "${home_tmux_conf}" ]]; then
    echo "Expected tmux config at ${home_tmux_conf} after stowing"
    exit 1
  fi

  local bootstrap_session="tpm-bootstrap-$$"
  local created_bootstrap_session=0

  if ! tmux has-session -t "${bootstrap_session}" 2>/dev/null; then
    tmux new-session -d -s "${bootstrap_session}"
    created_bootstrap_session=1
  fi

  tmux source-file "${home_tmux_conf}"

  if [[ ! -x "${home_tpm_install}" ]]; then
    echo "Expected TPM install script at ${home_tpm_install}"
    exit 1
  fi

  "${home_tpm_install}"

  if [[ "${created_bootstrap_session}" -eq 1 ]]; then
    tmux kill-session -t "${bootstrap_session}" 2>/dev/null || true
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
    install_tmux_tpm
    ;;
  install-stow)
    install_stow
    ;;
  install-dotfiles)
    run_stow "" "${PACKAGES[@]}"
    ;;
  install-tmux-tpm)
    install_tmux_tpm
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
