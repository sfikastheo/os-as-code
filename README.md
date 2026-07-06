## OS as Code

Declarative system configuration for NixOS and Home Manager using flakes.

## Build the flake

```bash
# Based on the machine, the build attribute needs to differ
sudo nixos-rebuild test --flake .#`system`
sudo nixos-rebuild build --flake .#`system`
sudo nixos-rebuild switch --flake .#`system`

# For only home-manager setups:
home-manager switch --flake ./home-manager#`system`
```

## Homebrew bundle

Homebrew dependencies are managed per profile with a `Brewfile`.

```bash
# Install or reconcile Homebrew dependencies for a profile
brew bundle install --file ./home-manager/`profile`/Brewfile

# Check whether all Brewfile dependencies are installed
brew bundle check --file ./home-manager/`profile`/Brewfile

# Generate or refresh a Brewfile from the current machine state
brew bundle dump --file ./home-manager/`profile`/Brewfile --force

# Remove Homebrew dependencies not present in the Brewfile
brew bundle cleanup --force --file ./home-manager/`profile`/Brewfile
```

## Common maintenance

```bash
# Clean old generations
sudo nix-collect-garbage --delete-older-than 7d

# Optimize store
nix-store --optimise

# Validate flake outputs
nix flake check

# Update inputs
nix flake update

# Update one input only
nix flake update nixpkgs

# Generate hardware-config
sudo nixos-generate-config --show-hardware-config > hardware-configuration.nix

# Roll back current system generation
sudo nixos-rebuild switch --rollback

# Home Manager rollback flow
home-manager generations
/nix/store/<generation>-home-manager-generation/activate
```
