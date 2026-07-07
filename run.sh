#!/usr/bin/env bash
set -euo pipefail

DOTFILE_PACKAGES=(
  mise
  zsh
  starship
  tmux
  nvim
  ghostty
  btop
  git
  psql
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
  install               Install system bootstrap packages if needed, install mise/tools, stow all packages, then install tmux TPM/plugins
  install-system        Install system bootstrap packages (jq and stow) using brew or pacman
  install-zsh           Stow only the zsh package into $HOME
  install-mise          Install mise if needed, stow only the mise package into $HOME, then run mise install
  install-starship      Stow only the starship package into $HOME
  install-tmux          Stow only the tmux package into $HOME
  install-nvim          Stow only the nvim package into $HOME
  install-ghostty       Stow only the ghostty package into $HOME
  install-btop          Stow only the btop package into $HOME
  install-git           Stow only the git package into $HOME
  install-psql          Stow only the psql package into $HOME
  install-agent-skills  Stow only the agents package into $HOME
  install-tmux-tpm      Clone TPM into the tmux package and install tmux plugins from tmux.conf
  remove-zsh            Unstow only the zsh package from $HOME
  remove-mise           Unstow only the mise package from $HOME
  remove-starship       Unstow only the starship package from $HOME
  remove-tmux           Unstow only the tmux package from $HOME
  remove-nvim           Unstow only the nvim package from $HOME
  remove-ghostty        Unstow only the ghostty package from $HOME
  remove-btop           Unstow only the btop package from $HOME
  remove-git            Unstow only the git package from $HOME
  remove-psql           Unstow only the psql package from $HOME
  remove-agent-skills   Unstow only the agents package from $HOME
  rebuild               Re-stow all packages (rebuild symlinks)
  remove                Unstow all installed package symlinks from $HOME
  dry-run               Preview what stowing the dotfile packages would do
  help                  Show this help
EOF
}

install_system() {
  if command -v jq >/dev/null 2>&1 && command -v stow >/dev/null 2>&1; then
    echo "system bootstrap packages are already installed"
    return 0
  fi

  log_step "Installing system bootstrap packages"

  if command -v brew >/dev/null 2>&1; then
    brew install jq stow
  elif command -v pacman >/dev/null 2>&1; then
    sudo pacman -Sy --noconfirm jq stow
  else
    echo "Could not find a supported package manager"
    echo "Expected brew on macOS or pacman on Linux"
    exit 1
  fi
}

ensure_stow() {
  if ! command -v stow >/dev/null 2>&1; then
    echo "stow is not installed"
    echo "Run: ./run.sh install-system"
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
  install_mise_binary
  install_system
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

install_ghostty() {
  log_step "Stowing ghostty configuration"
  run_stow "" ghostty
}

install_btop() {
  log_step "Stowing btop configuration"
  run_stow "" btop
}

install_git() {
  log_step "Stowing git configuration"
  run_stow "" git
}

install_psql() {
  log_step "Stowing psql configuration"
  run_stow "" psql
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

remove_ghostty() {
  log_step "Removing ghostty configuration"
  run_stow "-D" ghostty
}

remove_btop() {
  log_step "Removing btop configuration"
  run_stow "-D" btop
}

remove_git() {
  log_step "Removing git configuration"
  run_stow "-D" git
}

remove_psql() {
  log_step "Removing psql configuration"
  run_stow "-D" psql
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
    install_mise
    install_zsh
    install_starship
    install_tmux
    install_nvim
    install_ghostty
    install_btop
    install_git
    install_psql
    install_agent_skills
    install_tmux_tpm
    reload_shell_if_requested
    ;;
  install-system)
    install_system
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
  install-ghostty)
    install_ghostty
    ;;
  install-btop)
    install_btop
    ;;
  install-git)
    install_git
    ;;
  install-psql)
    install_psql
    ;;
  install-agent-skills)
    install_agent_skills
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
  remove-ghostty)
    remove_ghostty
    ;;
  remove-btop)
    remove_btop
    ;;
  remove-git)
    remove_git
    ;;
  remove-psql)
    remove_psql
    ;;
  remove-agent-skills)
    remove_agent_skills
    ;;
  rebuild)
    run_stow "-R" "${DOTFILE_PACKAGES[@]}" "${AGENT_PACKAGES[@]}"
    ;;
  remove)
    remove_agent_skills
    remove_psql
    remove_git
    remove_btop
    remove_ghostty
    remove_nvim
    remove_tmux
    remove_starship
    remove_zsh
    remove_mise
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
