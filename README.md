## OS as Code

Declarative system configuration for NixOS and home-manager using Nix flakes.

### Structure

```
├── flake.nix                    # Main flake for NixOS system
├── nixos/
│   └── framework13/             # NixOS configuration for Framework 13
├── home-manager/
│   ├── flake.nix                # Separate flake for macOS home-manager
│   ├── sfnix/                   # Linux user configuration
│   ├── sfikastheo/              # macOS user configuration
│   └── shared/                  # Shared configuration across systems
```

### General Maintenance

```bash
# Clean Old Generations
sudo nix-collect-garbage --delete-older-than 7d

# Optimize Nix Store
nix-store --optimise

# Verify flake syntax and structure:
nix flake check

# Update flake inputs (nixpkgs, home-manager, etc.):
nix flake update

# Update specific input only:
nix flake update nixpkgs

```

### NixOS

```bash
# Test the configuration without making it the boot default:
sudo nixos-rebuild test --flake .#nds

# Build the configuration without activating it:
sudo nixos-rebuild build --flake .#nds

# Build and activate the configuration, making it the boot default:
sudo nixos-rebuild switch --flake .#nds

# Rollback to previous generation:
sudo nixos-rebuild switch --rollback
```

### Home-Manager (MacOS)

```bash
# Build and activate without adding to profile:
home-manager switch --flake .#sfikastheo

# Rollback
home-manager generations
/nix/store/xxx-home-manager-generation/activate

```
