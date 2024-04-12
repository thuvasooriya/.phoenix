{
  outputs,
  pkgs,
  config,
  inputs,
  lib,
  ...
}: {
  imports = [
    ./fish.nix
    ./git.nix
    ./nvim.nix
    ./config.nix
    # ./tmux.nix
  ];

  targets.genericLinux.enable = pkgs.stdenv.isLinux;
  programs = {
    home-manager.enable = true;
    starship = {
      enable = true;
      enableZshIntegration = true;
      enableFishIntegration = true;
      enableTransience = true;
      settings = pkgs.lib.importTOML ../config/starship.toml;
    };
    zoxide = {
      enable = true;
      enableFishIntegration = true;
    };
    nushell.enable = true;
    nix-index = {
      enable = true;
      enableFishIntegration = true;
    };
    man = {
      enable = true;
      generateCaches = true;
    };
    keychain = {
      enable = true;
      enableFishIntegration = true;
      keys = ["id_ed25519"];
      # agents = [];
    };
  };
  home = {
    stateVersion = "23.11";
    packages = with pkgs;
      [
        coreutils
        curl
        rsync
        hyperfine
        fzf
        rsync
        neofetch
        # docker

        luajit
        xonsh
        bat
        # exa
        lsd
        zellij
        rmtrash
        # mcfly
        dogdns
        htop
        gron
        # mosh
        # lua

        nodejs
        # nodejs_21

        (python3.withPackages
          (p: [
            # p.pandas
            p.pip
            p.python-lsp-server
          ]))
        pipx
      ]
      ++ lib.optionals pkgs.stdenv.isDarwin [
        yt-dlp
        cmatrix
        aria2
        verilog
        tectonic
        verilator
        (writeShellScriptBin "darwinix" ''
          darwin-rebuild switch --flake ~/.phoenix/
        '')
      ]
      ++ lib.optionals pkgs.stdenv.isLinux [
        (writeShellScriptBin "update-home" ''
          home-manager switch --flake ~/.phoenix/home/
        '')
      ];

    file = {
    };

    sessionVariables = {
      EDITOR = "nvim";
    };
    # using bun and zvm outside of nix
    sessionPath = ["$HOME/.zvm/bin" "$HOME/.zvm/self" "$HOME/.bun/bin" "~/Library/TinyTeX"];
  };
  # ++ lib.optionals pkgs.stdenv.isLinux {
  #   username = "tony";
  #   homeDirectory = "/home/tony";
  # };
}
