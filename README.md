# Dotfiles Setup

This repo uses [GNU Stow](https://www.gnu.org/software/stow/) to manage dotfiles as symlinks in your home directory and uses [TPM](https://github.com/tmux-plugins/tpm) to install tmux plugins declared in `tmux/.config/tmux/tmux.conf`.

## Packages managed by Stow

They are processed in this install/rebuild order:

1. `zsh`
2. `mise`
3. `starship`
4. `tmux`
5. `nvim`
6. `agents`

For removal, the script unstows them in reverse order.

## Prerequisites

1. Clone this repo
2. Run commands from the repo root

## Steps

### 1. Install Everything

For a full setup on a new machine, run:

```bash
./run.sh install
```

This installs GNU Stow if needed, stows all dotfiles in the defined order, then bootstraps TPM and installs tmux plugins from `tmux.conf`.

### 2. Individual Commands

Install GNU Stow only:

```bash
./run.sh install-stow
```

Preview dotfile changes first:

```bash
./run.sh dry-run
```

Install dotfiles only:

```bash
./run.sh install-dotfiles
```

Install tmux TPM and the tmux plugins declared in `tmux/.config/tmux/tmux.conf`:

```bash
./run.sh install-tmux-tpm
```

### 3. Install tmux TPM

Run this after `install-dotfiles` if you want to bootstrap TPM separately:

```bash
./run.sh install-tmux-tpm
```

What it does:

1. Ensures `tmux/.config/tmux/plugins` exists
2. Clones TPM into `tmux/.config/tmux/plugins/tpm`
3. Re-stows the `tmux` package
4. Loads tmux config from `$HOME/.config/tmux/tmux.conf`
5. Runs TPM's `install_plugins` command to fetch plugins listed in `tmux.conf`

This step requires both `git` and `tmux` to be installed.

### 4. Rebuild

Use this after changing files in the repo to refresh symlinks in the same defined order:

```bash
./run.sh rebuild
```

### 5. Remove

Remove all symlinks created by stow in reverse order:

```bash
./run.sh remove
```

## Notes

- Symlinks target `$HOME`
- If a target file already exists, `stow` may report a conflict
- Back up or remove conflicting files before installing
- `install-stow` supports `brew`, `apt-get`, `dnf`, `yay`, and `pacman`
- `install` is the one-command bootstrap for a new machine
- `install-dotfiles` applies the managed configs without reinstalling prerequisites
