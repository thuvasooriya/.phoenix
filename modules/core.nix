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
    go = {
      enable = true;
      packages = {
        # "https://pkg.go.dev/github.com/yuin/goldmark" = builtins.fetchGit "https://github.com/yuin/goldmark";
      };
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
        scrcpy
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
        # go

        nodejs
        # nodejs_21

        raylib

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
        hugo
        # tectonic
        # llvmPackages.clang-unwrapped
        # llvmPackages_17.clang-unwrapped

        # digital design
        verilator
        verilog
        gtkwave
        # verible
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
