# Dotfiles Setup

This repo uses [GNU Stow](https://www.gnu.org/software/stow/) to manage dotfiles as symlinks in your home directory.

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

This installs GNU Stow if needed, then stows all dotfiles in the defined order.

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

### 3. Rebuild

Use this after changing files in the repo to refresh symlinks in the same defined order:

```bash
./run.sh rebuild
```

### 4. Remove

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
