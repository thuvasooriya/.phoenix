set shell := ["nu", "-c"]

@_default:
    just --list --list-heading ''

# incomplete implementation of tests
test:
    nix eval .#evalTests --show-trace --print-build-logs --verbose

# nix flake update
up:
    nix flake update

# nix flake update for input
upp input:
    nix flake update {{ input }}

# nix profile history
history:
    nix profile history --profile /nix/var/nix/profiles/system

# open a nix shell with the flake
repl:
    nix repl -f flake:nixpkgs

# remove all generations older than 7 days
clean_history:
    sudo nix profile wipe-history --profile /nix/var/nix/profiles/system  --older-than 1d

# garbage collect all unused nix store entries
gc:
    sudo nix store gc --debug
    nix store gc --debug
    sudo nix-collect-garbage --delete-old
    nix-collect-garbage -d

# remove all reflog entries and prune unreachable objects
gitgc:
    git reflog expire --expire-unreachable=now --all
    git gc --prune=now

# repair errors and cleanup store
repair:
    sudo nix store optimise
    nix store optimise
    sudo nix-store --verify --check-contents --repair
    nix-store --verify --check-contents --repair

# all cleaning scripts
clean: clean_history gc gitgc repair

# [macos]
# darwin-set-proxy:
#   sudo python3 scripts/darwin_set_proxy.py
#   sleep 1sec

# rollback
[macos]
darwin-rollback:
    use utils.nu *; \
    darwin-rollback

# deploy madhu
[macos]
ma mode="default":
    use utils.nu *; \
    darwin-build "madhu" {{ mode }}; \
    darwin-switch "madhu" {{ mode }}

# reload yabai and skhd(macos)
# [macos]
# yabai-reload:
#     launchctl kickstart -k "gui/502/org.nixos.yabai";
#     launchctl kickstart -k "gui/502/org.nixos.skhd";
