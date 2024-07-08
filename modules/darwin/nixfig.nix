{
  nixpkgs,
  pkgs,
  lib,
  ...
}: {
  # enable flakes globally
  # nix.settings.experimental-features = ["nix-command" "flakes"];
  # Disable auto-optimise-store because of this issue:
  #   https://github.com/NixOS/nix/issues/7273
  # "error: cannot link '/nix/store/.tmp-link-xxxxx-xxxxx' to '/nix/store/.links/xxxx': File exists"
  nix.settings = {
    auto-optimise-store = false;
    experimental-features = ["nix-command" "flakes"];
    # substituters = [
    #   "https://cache.nixos.org/"
    #   "https://nix-community.cachix.org"
    # ];
    # trusted-public-keys = [
    #   "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    # ];
  };

  # allow unfree packages
  nixpkgs.config.allowUnfree = true;

  nixpkgs.hostPlatform = {
    config = "aarch64-apple-darwin";
    system = "aarch64-darwin";
  };

  # nix.extraoptions =
  #   ''
  #   ''
  #   + lib.optionalstring (pkgs.system == "aarch64-darwin") ''
  #     extra-platforms = x86_64-darwin aarch64-darwin
  #   '';

  # auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  # use this instead of services.nix-daemon.enable if you
  # don't wan't the daemon service to be managed for you.
  # nix.useDaemon = true;

  # nix.package = pkgs.nix;
  nix.package = pkgs.nixFlakes;
  nix.registry.nixpkgs.flake = nixpkgs;

  environment.etc."nix/inputs/nixpkgs".source = "${nixpkgs}";
  # make `nix repl '<nixpkgs>'` use the same nixpkgs as the one used by this flake.
  # discard all the default paths, and only use the one from this flake.
  nix.nixPath = lib.mkForce ["/etc/nix/inputs"];

  # do garbage collection weekly to keep disk usage low
  nix.gc = {
    automatic = lib.mkDefault true;
    options = lib.mkDefault "--delete-older-than 10d";
    # interval = {
    #   Hour = 48;
    #   Minute = 0;
    # };
  };
}
