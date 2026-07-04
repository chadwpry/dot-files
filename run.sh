#!/usr/bin/env bash
set -euo pipefail

DOTFILE_PACKAGES=(
  mise
  zsh
  starship
  tmux
  nvim
)

AGENT_PACKAGES=(
  agents
)

TARGET_DIR="${HOME}"
RELOAD_SHELL=1

usage() {
  cat <<'EOF'
Usage: ./run.sh <command> [--no-reload-shell]

Options:
  --no-reload-shell  Skip automatic shell reload for install and install-zsh

Commands:
  install               Install GNU Stow if needed, install mise/tools, stow all packages, then install tmux TPM/plugins
  install-stow          Install GNU Stow using a supported package manager
  install-zsh           Stow only the zsh package into $HOME
  install-mise          Install mise if needed, stow only the mise package into $HOME, then run mise install
  install-starship      Stow only the starship package into $HOME
  install-tmux          Stow only the tmux package into $HOME
  install-nvim          Stow only the nvim package into $HOME
  install-agent-skills  Stow only the agents package into $HOME
  install-dotfiles      Install mise/tools, then stow all dotfile packages into $HOME
  install-tmux-tpm      Clone TPM into the tmux package and install tmux plugins from tmux.conf
  remove-zsh            Unstow only the zsh package from $HOME
  remove-mise           Unstow only the mise package from $HOME
  remove-starship       Unstow only the starship package from $HOME
  remove-tmux           Unstow only the tmux package from $HOME
  remove-nvim           Unstow only the nvim package from $HOME
  remove-agent-skills   Unstow only the agents package from $HOME
  rebuild               Re-stow all packages (rebuild symlinks)
  remove                Unstow all installed package symlinks from $HOME
  dry-run               Preview what install-dotfiles would do
  help                  Show this help
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

log_step() {
  echo
  echo "==> $1"
}

detect_shell_name() {
  local shell_path="${SHELL:-}"

  if [[ -n "${shell_path}" ]]; then
    basename "${shell_path}"
  else
    echo ""
  fi
}

mise_bin() {
  if command -v mise >/dev/null 2>&1; then
    command -v mise
  elif [[ -x "${HOME}/.local/bin/mise" ]]; then
    echo "${HOME}/.local/bin/mise"
  else
    return 1
  fi
}

install_mise_binary() {
  if mise_bin >/dev/null 2>&1; then
    echo "mise is already installed"
    return 0
  fi

  ensure_command curl "Please install curl and rerun this script"

  local shell_name
  shell_name="$(detect_shell_name)"

  case "${shell_name}" in
    zsh|bash)
      log_step "Installing mise for ${shell_name}"
      curl "https://mise.run/${shell_name}" | sh
      ;;
    *)
      echo "Could not determine a supported shell from SHELL='${SHELL:-unset}'"
      echo "Please install mise manually, then rerun this script"
      exit 1
      ;;
  esac
}

reload_shell_if_requested() {
  if [[ "${RELOAD_SHELL}" -eq 0 ]]; then
    echo "Skipping shell reload because --no-reload-shell was provided"
    return 0
  fi

  if [[ ! -t 0 || ! -t 1 ]]; then
    echo "Skipping shell reload because this session is not interactive"
    return 0
  fi

  local shell_name
  shell_name="$(detect_shell_name)"

  case "${shell_name}" in
    zsh|bash)
      log_step "Reloading ${shell_name} as a login shell"
      exec "${SHELL}" -l
      ;;
    *)
      echo "Skipping shell reload because SHELL='${SHELL:-unset}' is not supported"
      echo "Start a new shell manually to load the updated configuration"
      return 0
      ;;
  esac
}

install_zsh() {
  log_step "Stowing zsh configuration"
  run_stow "" zsh
  echo "zsh configuration installed at ${HOME}/.zshrc"
}

install_mise() {
  ensure_stow
  install_mise_binary
  log_step "Stowing mise configuration"
  run_stow "" mise

  local mise_cmd
  mise_cmd="$(mise_bin)"

  log_step "Installing tools from mise configuration"
  "${mise_cmd}" install
}

install_starship() {
  log_step "Stowing starship configuration"
  run_stow "" starship
}

install_tmux() {
  log_step "Stowing tmux configuration"
  run_stow "" tmux
}

install_nvim() {
  log_step "Stowing neovim configuration"
  run_stow "" nvim
}

install_agent_skills() {
  log_step "Stowing agent skills"
  run_stow "" agents
}

remove_zsh() {
  log_step "Removing zsh configuration"
  run_stow "-D" zsh
}

remove_mise() {
  log_step "Removing mise configuration"
  run_stow "-D" mise
}

remove_starship() {
  log_step "Removing starship configuration"
  run_stow "-D" starship
}

remove_tmux() {
  log_step "Removing tmux configuration"
  run_stow "-D" tmux
}

remove_nvim() {
  log_step "Removing neovim configuration"
  run_stow "-D" nvim
}

remove_agent_skills() {
  log_step "Removing agent skills"
  run_stow "-D" agents
}

install_tmux_tpm() {
  local repo_plugins_dir="tmux/.config/tmux/plugins"
  local repo_tpm_dir="${repo_plugins_dir}/tpm"
  local home_tmux_conf="${HOME}/.config/tmux/tmux.conf"
  local home_tpm_install="${HOME}/.config/tmux/plugins/tpm/bin/install_plugins"

  log_step "Installing tmux TPM and plugins"
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

COMMAND="${1:-help}"
if [[ $# -gt 0 ]]; then
  shift
fi

while [[ $# -gt 0 ]]; do
  case "$1" in
    --no-reload-shell)
      RELOAD_SHELL=0
      ;;
    help|--help|-h)
      usage
      exit 0
      ;;
    *)
      echo "Unknown option: $1"
      echo
      usage
      exit 1
      ;;
  esac
  shift
done

case "${COMMAND}" in
  install)
    install_stow
    install_mise
    install_zsh
    install_starship
    install_tmux
    install_nvim
    install_agent_skills
    install_tmux_tpm
    reload_shell_if_requested
    ;;
  install-stow)
    install_stow
    ;;
  install-zsh)
    install_zsh
    reload_shell_if_requested
    ;;
  install-mise)
    install_mise
    ;;
  install-starship)
    install_starship
    ;;
  install-tmux)
    install_tmux
    ;;
  install-nvim)
    install_nvim
    ;;
  install-agent-skills)
    install_agent_skills
    ;;
  install-dotfiles)
    install_mise
    install_zsh
    install_starship
    install_tmux
    install_nvim
    ;;
  install-tmux-tpm)
    install_tmux_tpm
    ;;
  remove-zsh)
    remove_zsh
    ;;
  remove-mise)
    remove_mise
    ;;
  remove-starship)
    remove_starship
    ;;
  remove-tmux)
    remove_tmux
    ;;
  remove-nvim)
    remove_nvim
    ;;
  remove-agent-skills)
    remove_agent_skills
    ;;
  rebuild)
    run_stow "-R" "${DOTFILE_PACKAGES[@]}" "${AGENT_PACKAGES[@]}"
    ;;
  remove)
    remove_agent_skills
    remove_nvim
    remove_tmux
    remove_starship
    remove_mise
    remove_zsh
    ;;
  dry-run)
    run_stow "-n" "${DOTFILE_PACKAGES[@]}"
    ;;
  help|--help|-h)
    usage
    ;;
  *)
    echo "Unknown command: ${COMMAND}"
    echo
    usage
    exit 1
    ;;
esac
