# https://github.com/nix-community/NixOS-WSL

# Download latest nixos-wsl build
# https://github.com/nix-community/NixOS-WSL/releases/tag/2405.5.4

# Install into WSL
```powershell
wsl --import NixOS --version 2 $env:USERPROFILE\NixOS\ nixos-wsl.tar.gz
```

# Run NixOS
wsl -d NixOS
