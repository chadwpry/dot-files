# Dotfiles Setup

This repo uses [GNU Stow](https://www.gnu.org/software/stow/) to manage dotfiles as symlinks in your home directory and uses [TPM](https://github.com/tmux-plugins/tpm) to install tmux plugins declared in `tmux/.config/tmux/tmux.conf`.

## Packages managed by Stow

Packages are processed in this install/rebuild order:

1. `mise`
2. `zsh`
3. `starship`
4. `tmux`
5. `nvim`
6. `ghostty`
7. `btop`
8. `git`
9. `agents`

For removal, the script runs the individual remove commands in reverse order.

## Prerequisites

1. Clone this repo
2. Run commands from the repo root

## Steps

### 1. Install Everything

For a full setup on a new machine, run:

```bash
./run.sh install
```

To skip the automatic shell reload at the end:

```bash
./run.sh install --no-reload-shell
```

This installs system bootstrap packages (`jq` and `stow`) if needed, installs `mise` if needed, stows the `mise` config, runs `mise install`, stows the remaining packages (`zsh`, `starship`, `tmux`, `nvim`, `ghostty`, `btop`, `git`, and `agents`), then bootstraps TPM and installs tmux plugins from `tmux.conf`.

### 2. Individual Commands

Install system bootstrap packages:

```bash
./run.sh install-system
```

Preview dotfile changes first:

```bash
./run.sh dry-run
```

Install packages individually:

```bash
./run.sh install-mise
./run.sh install-zsh
./run.sh install-starship
./run.sh install-tmux
./run.sh install-nvim
./run.sh install-ghostty
./run.sh install-btop
./run.sh install-git
./run.sh install-agent-skills
```

You can also skip shell reload for `install-zsh`:

```bash
./run.sh install-zsh --no-reload-shell
```

Remove packages individually:

```bash
./run.sh remove-zsh
./run.sh remove-mise
./run.sh remove-starship
./run.sh remove-tmux
./run.sh remove-nvim
./run.sh remove-ghostty
./run.sh remove-btop
./run.sh remove-git
./run.sh remove-agent-skills
```

Install all dotfile packages at once:

```bash
./run.sh install-dotfiles
```

`install-dotfiles` installs `mise` if needed, stows the `mise` config, runs `mise install`, then stows `zsh`, `starship`, `tmux`, `nvim`, `ghostty`, `btop`, and `git`.

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
- `install-system` uses `brew` on macOS or `pacman` on Linux to install `jq` and `stow`
- `mise` bootstrap package definitions currently include `brew:jq`, `brew:stow`, `pacman:jq`, and `pacman:stow`
- `mise` bootstrap currently supports `zsh` and `bash` based on `$SHELL`
- `.zshrc` defensively initializes `mise`, `starship`, and `fzf` only when those binaries are available
- `install` is the one-command bootstrap for a new machine, includes every package plus tmux TPM/plugin setup, and reloads the shell by default
- `install-dotfiles` installs `mise` if needed, runs `mise install`, and applies the dotfile packages (`mise`, `zsh`, `starship`, `tmux`, `nvim`, `ghostty`, `btop`, and `git`)
- `install-mise` installs `mise` with the shell-appropriate bootstrap URL when needed, ensures system bootstrap packages are installed, stows its config, and runs `mise install`
- `install-zsh` reloads the shell by default after stowing `.zshrc`; pass `--no-reload-shell` to skip that
- `install-zsh`, `install-starship`, `install-tmux`, `install-nvim`, `install-ghostty`, `install-btop`, `install-git`, and `install-agent-skills` each stow only their matching package
- `remove-zsh`, `remove-mise`, `remove-starship`, `remove-tmux`, `remove-nvim`, `remove-ghostty`, `remove-btop`, `remove-git`, and `remove-agent-skills` each unstow only their matching package
- `remove` runs all package remove commands in reverse install order

## Git identity configuration

The git config in this repo uses Git conditional includes to switch the commit `[user]` name and email based on the repository's remote URL. Your fallback identity lives directly in `~/.config/git/config-identities`, with optional conditional overrides below it.

### How it works

1. The main config (`git/.config/git/config`) includes one local file at the end:

```ini
[include]
  path = ~/.config/git/config-identities
```

2. `~/.config/git/config-identities` is **not committed** (it is ignored by `git/.config/git/.gitignore`). It contains your default `[user]` identity at the top plus any `includeIf` rules for more specific identities:

```ini
[user]
  name = Your Name
  email = your.default.email@example.com

[includeIf "hasconfig:remote.*.url:git@github.com:my-org/**"]
  path = config-my-org
```

3. A matched identity file overrides the `[user]` section:

```ini
[user]
  name = Your Name
  email = your.work.email@example.com
```

### Setting up your identities

1. Copy the template:

```bash
cp git/.config/git/config-identities.template git/.config/git/config-identities
```

2. Edit `git/.config/git/config-identities` and set your default identity at the top:

```ini
[user]
  name = Your Name
  email = your.default.email@example.com
```

3. Create a per-identity file, for example `git/.config/git/config-work`:

```ini
[user]
  name = Your Name
  email = your.work.email@example.com
```

4. Add a conditional include in `git/.config/git/config-identities`:

```ini
[includeIf "hasconfig:remote.*.url:git@github.com:my-org/**"]
  path = config-work
```

5. Re-stow the git package so the files are linked into `~/.config/git/`:

```bash
./run.sh install-git
```

6. Test it by running `git config user.email` inside repositories whose remote URLs match and do not match the pattern.

### Sharing the setup with teammates

If someone asks how the identity switching works, you can share this short summary:

> Our dotfiles use Git's conditional includes. The main git config loads `~/.config/git/config-identities`, which contains your default `[user]` name/email at the top plus optional `includeIf` rules for repo-specific identities. Matching rules load `config-<name>` files that override the identity for those repos. These files are gitignored, so they stay personal and are never committed. To set them up, copy `config-identities.template` to `config-identities`, set your default identity there, create any `config-<name>` override files you need, add the matching `includeIf` rules, and run `./run.sh install-git`.
