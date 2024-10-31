{
  pkgs,
  myvars,
  ...
} @ args: {
  nixpkgs.overlays =
    [
    ]
    ++ (import ../overlays args);

  nix.package = pkgs.nixVersions.latest;

  environment.systemPackages = with pkgs; [
    neovim
    git
    git-lfs
    just
    mtr
  ];

  ## todo: ghostty terminfo config for sbcs
  # TERMINFO_DIRS = "${pkgs.kitty.terminfo.outPath}/share/terminfo";
  environment = {
    variables.EDITOR = "nvim";
    # shells = [pkgs.zsh];
    pathsToLink = [];
    systemPath = [
    ];
  };

  users.users.${myvars.username} = {
    description = myvars.userfullname;
    # since its authority is so large, we must strengthen its security:
    # 1. The corresponding private key must be:
    #    1. Generated locally on every trusted client via:
    #      ```bash
    #      # KDF: bcrypt with 256 rounds, takes 2s on Apple M2):
    #      # Passphrase: digits + letters + symbols, 12+ chars
    #      ssh-keygen -t ed25519 -a 256 -C "ryan@xxx" -f ~/.ssh/xxx`
    #      ```
    #    2. Never leave the device and never sent over the network.
    # 2. Or just use hardware security keys like Yubikey/CanoKey.
    # openssh.authorizedKeys.keys = [
    #   "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIKlN+Q/GxvwxDX/OAjJHaNFEznEN4Tw4E4TwqQu/eD6 ryan@idols-ai"
    #   "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPoa9uEI/gR5+klqTQwvCgD6CD5vT5iD9YCNx2xNrH3B ryan@fern"
    #   "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPwZ9MdotnyhxIJrI4gmVshExHiZOx+FGFhcW7BaYkfR ryan@harmonica"
    # ];
  };

  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    trusted-users = [myvars.username];

    substituters = [
      "https://nix-community.cachix.org"
    ];
    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];

    # extract these to a separate project file
    extra-substituters = [
      "https://openlane.cachix.org"
    ];
    extra-trusted-public-keys = [
      "openlane.cachix.org-1:qqdwh+QMNGmZAuyeQJTH9ErW57OWSvdtuwfBKdS254E="
    ];

    builders-use-substitutes = true;
  };
}
