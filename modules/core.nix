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
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    bun = {
      enable = true;
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
    fzf = {
      enable = true;
      enableFishIntegration = true;
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
        # fzf
        rsync
        neofetch
        scrcpy
        docker
        colima
        # x11docker
        xquartz
        xorg.xauth

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
            p.pip
          ]))
        pipx
      ]
      ++ lib.optionals pkgs.stdenv.isDarwin [
        yt-dlp
        cmatrix
        aria2
        hugo
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
      # ".config/nvim" = {
      #   source = ../config/nvim;
      #   recursive = true;
      ".rgignore".source = config.lib.file.mkOutOfStoreSymlink ../config/.rgignore;
      ".rules.verible_lint".source = config.lib.file.mkOutOfStoreSymlink ../config/.rules.verible_lint;
    };

    sessionVariables = {
      EDITOR = "nvim";
    };
    # need to do something about these things
    sessionPath = ["$HOME/.zvm/bin" "$HOME/.zvm/self" "$HOME/.local/bin"];
  };
  # ++ lib.optionals pkgs.stdenv.isLinux {
  #   username = "tony";
  #   homeDirectory = "/home/tony";
  # };
}
