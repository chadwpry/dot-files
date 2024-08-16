# dot-files

## Setup

### Setup $XDG_CONFIG_HOME

Add base directory

```zsh
mkdir -p ~/.config
```

### Nix

Install nix on the computer

```zsh
sh <(curl -L https://nixos.org/nix/install) --daemon
```

Install home-manager

```zsh
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install
```

Install packages and create configuration files with home-manager

```zsh
home-manager switch
```

### Git

Configure $GITUSER, $GITEMAIL

```zsh
export $GITUSER="<git name>"
export $GITEMAIL="<git email>"
```

### Tmux

Retrieve tpm plugin submodule in tmux/plugins/tmux

```zsh
git submodules update --init
```
