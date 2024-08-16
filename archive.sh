ARCHIVED="$HOME/dotfiles/archived/$(date "+%Y-%m-%dT%H:%M:%S")"

# create base directory
mkdir -p $ARCHIVED/.local/share
echo created $ARCHIVED/.local/share directory

mkdir -p $ARCHIVED/.local/state
echo created $ARCHIVED/.local/state directory

# create .local/state directories
cp -r ~/.local/share/nvim $ARCHIVED/.local/share
echo copied $HOME/.local/shared/nvim directory

cp -r ~/.local/share/tmux $ARCHIVED/.local/share
echo copied $HOME/.local/shared/tmux directory

# create .local/share directories
cp -r ~/.local/share/vim-lsp-settings $ARCHIVED/.local/share
echo copied $HOME/.local/shared/vim-lsp-settings directory

cp -r ~/.local/state/nvim $ARCHIVED/.local/state
echo copied $HOME/.local/state/nvim directory

cp -r ~/.local/state/tmux $ARCHIVED/.local/state
echo copied $HOME/.local/state/tmux directory

# create .config directories
cp -r ~/.config/nvim $ARCHIVED/.config
echo copied $HOME/.config/nvim directory

cp -r ~/.config/tmux $ARCHIVED/.config
echo copied $HOME/.config/tmux directory

cp -r ~/.tmux $ARCHIVED
echo copied $HOME/.tmux directory

cp -r ~/.zshrc $ARCHIVED
echo copied $HOME/.zshrc file

cp -r ~/.gitconfig $ARCHIVED
echo copied $HOME/.gitconfig file

