## OS as Code

Declarative system configuration for NixOS and Home Manager using flakes.

## Current topology

| Flake                    | Host/User              | Attribute                   | Config path                         |
| ------------------------ | ---------------------- | --------------------------- | ----------------------------------- |
| Root `flake.nix`         | Framework 13 (`sfnix`) | `.#fw13`                    | `nixos/nds` + `home-manager/sfnix`  |
| Root `flake.nix`         | NUC (`wsuser`)         | `.#nuc01`                   | `nixos/ws1` + `home-manager/wsuser` |
| `home-manager/flake.nix` | macOS (`sfikastheo`)   | `./home-manager#sfikastheo` | `home-manager/sfikastheo`           |

## Build the flake

```bash
# Based on the machine, the build attribute needs to differ
# For NixOS, the available attributes are .#fw13 and .#nuc01

sudo nixos-rebuild test --flake .#fw13||.#nuc01
sudo nixos-rebuild build --flake .#fw13||.#nuc01
sudo nixos-rebuild switch --flake .#fw13||.#nuc01

# For macOS, only home-manager is used
home-manager switch --flake ./home-manager#sfikastheo
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
