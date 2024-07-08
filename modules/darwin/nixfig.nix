{
  nixpkgs,
  lib,
  ...
}: {
  nixpkgs.config.allowUnfree = true;

  services.nix-daemon.enable = true;

  nix.registry.nixpkgs.flake = nixpkgs;
  nix.settings.auto-optimise-store = false;
  nix.gc.automatic = false;

  environment.etc."nix/inputs/nixpkgs".source = "${nixpkgs}";
  # make `nix repl '<nixpkgs>'` use the same nixpkgs as the one used by this flake.
  # discard all the default paths, and only use the one from this flake.
  nix.nixPath = lib.mkForce ["/etc/nix/inputs"];
}
