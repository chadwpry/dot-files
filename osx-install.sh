# https://determinate.systems/posts/determinate-nix-installer/

# determinate systems installer
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install

# setup certs
# https://github.com/NixOS/nix/issues/8771#issuecomment-1662633816
sudo ln -s /nix/var/nix/profiles/default/etc/ssl/certs/ca-bundle.crt /etc/ssl/certs/ca-certificates.crt

# home manager
# nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
# nix-channel --update

# nix-shell '<home-manager>' -A install

# source $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh
