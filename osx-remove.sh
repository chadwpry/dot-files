# https://github.com/NixOS/nix/blob/bf7dc3c7dc24f75fa623135750e8f10b8bcd94f9/doc/manual/src/installation/uninstall.md#macos
# https://nix.dev/manual/nix/2.18/installation/uninstall

# nix-darwin

darwin-uninstall

# certs
sudo rm /etc/ssl/certs/ca-certificates.crt

# nix

# /etc/*
sudo mv /etc/zshrc.backup-before-nix /etc/zshrc
sudo mv /etc/bashrc.backup-before-nix /etc/bashrc
sudo mv /etc/bash.bashrc.backup-before-nix /etc/bash.bashrc

# daemons
echo daemon unloading and removal should be handled by darwin-uninstall
# sudo launchctl unload /Library/LaunchDaemons/org.nixos.nix-daemon.plist
# sudo rm /Library/LaunchDaemons/org.nixos.nix-daemon.plist
# sudo launchctl unload /Library/LaunchDaemons/org.nixos.darwin-store.plist
# sudo rm /Library/LaunchDaemons/org.nixos.darwin-store.plist

# nixbld users
sudo dscl . -delete /Groups/nixbld
for u in $(sudo dscl . -list /Users | grep _nixbld); do sudo dscl . -delete /Users/$u; done

# fstab
sudo vifs

# /etc/synthetic.conf
sudo rm /etc/synthetic.conf

# root files
echo removed etc files removal as darwin-uninstall should handle it
# sudo rm -rf /etc/nix
sudo rm -rf /private/var/root/.nix-profile /private/var/root/.nix-defexpr /private/var/root/.nix-channels

# user files
sudo rm -rf ~/.nix-profile ~/.nix-defexpr ~/.nix-channels

# disk password
sudo security delete-generic-password  -a "Nix Store" -s "Nix Store" -l "disk3 encryption password" -D "Encrypted volume password"

# nix store apfs volume
sudo diskutil apfs deleteVolume /nix

diskutil list

