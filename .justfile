# just is a command runner, Justfile is very similar to Makefile, but simpler.
set shell:= ["nu","-c"]

test:
  nix eval .#evalTests --show-trace --print-build-logs --verbose

up:
  nix flake update

upp input:
  nix flake update {{input}}

history:
  nix profile history --profile /nix/var/nix/profiles/system
  
# Open a nix shell with the flake
repl:
  nix repl -f flake:nixpkgs

# remove all generations older than 7 days
clean:
  sudo nix profile wipe-history --profile /nix/var/nix/profiles/system  --older-than 7d

# Garbage collect all unused nix store entries
gc:
  # garbage collect all unused nix store entries
  sudo nix store gc --debug
  sudo nix-collect-garbage --delete-old

# Remove all reflog entries and prune unreachable objects
gitgc:
  git reflog expire --expire-unreachable=now --all
  git gc --prune=now
############################################################################
#
#  Darwin related commands
#
############################################################################
[macos]
darwin-set-proxy:
  sudo python3 scripts/darwin_set_proxy.py
  sleep 1sec

[macos]
darwin-rollback:
  use utils.nu *; \
  darwin-rollback

# deploy modhu
[macos]
ma mode="default":
  use utils.nu *; \
  darwin-build "madhu" {{mode}}; \
  darwin-switch "madhu" {{mode}}


# Reload yabai and skhd(macOS)
[macos]
yabai-reload:
  launchctl kickstart -k "gui/502/org.nixos.yabai";
  launchctl kickstart -k "gui/502/org.nixos.skhd"; 

