{
  pkgs,
  myvars,
  ...
} @ args: {
  environment.systemPackages = with pkgs; [
    nushell
    fish
    neovim
    git
    git-lfs
    just
    mtr
  ];
  programs.fish.enable = true;

  ## todo: ghostty terminfo config for sbcs
  # TERMINFO_DIRS = "${pkgs.kitty.terminfo.outPath}/share/terminfo";
  environment = {
    variables.EDITOR = "nvim";
    shells = [pkgs.zsh pkgs.fish pkgs.nushell];
    shellAliases = {
      nx = "nix develop -c $SHELL";
    };
    pathsToLink = [];
    systemPath = [
    ];
  };

  nixpkgs.overlays =
    [
    ]
    ++ (import ../overlays args);
  users.knownUsers = ["${myvars.username}"];
  users.users.${myvars.username} = {
    description = myvars.userfullname;
    uid = 501;
    shell = pkgs.fish;
  };

  nix.package = pkgs.nixVersions.latest;
  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    trusted-users = [myvars.username];
    substituters = [
      "https://nix-community.cachix.org"
    ];
    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
    builders-use-substitutes = true;
  };
}
