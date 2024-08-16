# clean up
rm -rf ~/.local/share/nvim
echo removed nvim from $XDG_CONFIG_HOME/.local/share

rm -rf ~/.local/state/nvim
echo removed nvim state from $XDG_CONFIG_HOME/.local/state

rm -rf ~/.local/share/tmux
echo removed tmux from $XDG_CONFIG_HOME/.local/share

rm -rf ~/.local/state/tmux
echo removed tmux state from $XDG_CONFIG_HOME/.local/state

rm -rf ~/.local/share/vim-lsp-settings
echo removed vim-lsp-settings from $XDG_CONFIG_HOME/.local/share

unlink ~/.config/nvim
echo removed nvim link from $XDG_CONFIG_HOME

unlink ~/.config/tmux
echo removed tmux link from $XDG_CONFIG_HOME

unlink ~/.config/zsh
echo removed zsh link from $XDG_CONFIG_HOME

unlink ~/.config/home-manager
echo removed home-manager from $XDG_CONFIG_HOME/.config

rm -rf ~/.tmux
echo removed .tmux directory from $HOME

# tmux package manager installation
# git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
# echo cloned tmux package manager to user .tmux directory

# create ~/.config if it doesn't exist already
mkdir -p ~/.config

# link tmux config directory to ~/.config/tmux ($XDG_CONFIG_HOME)
ln -s $HOME/dotfiles/tmux $HOME/.config/tmux
echo linked tmux configuration to $XDG_CONFIG_HOME

# link nvim config directory to ~/.config/nvim
ln -s $HOME/dotfiles/nvim $HOME/.config/nvim
echo linked nvim configuration to $XDG_CONFIG_HOME

ln -s $HOME/dotfiles/zsh $HOME/.config
echo linked zsh configurations to $XDG_CONFIG_HOME

ln -s $HOME/dotfiles/home-manager $HOME/.config
echo linked home-manager configuration to $XDG_CONFIG_HOME

# sh <(curl -L https://nixos.org/nix/install) --daemon
#
# nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
# nix-channel --update
#
# nix-shell '<home-manager>' -A install

# copy fonts to local machine for mac
if [[ $OSTYPE == 'darwin'* ]]; then
  cp -rf $HOME/dotfiles/fonts/*.ttf ~/Library/Fonts
  echo copied fonts on mac system
fi

