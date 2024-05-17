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
    nnn = {
      enable = true;
      extraPackages = [];
      package = pkgs.nnn.override {withNerdIcons = true;};
      plugins = {
        mappings = {
          d = "fzcd";
          # p = "preview-tui";
          f = "finder";
        };
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
        ollama
        llama-cpp
        ffmpeg
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
        # yt-dlp use nightly bin files instead
        cmatrix
        aria2
        hugo
        flyctl
        # llvmPackages.clang-unwrapped
        # llvmPackages_17.clang-unwrapped

        # digital design
        verilator
        verilog
        gtkwave
        typst
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
      # ".aria2/aria2.conf".source = config.lib.file.mkOutOfStoreSymlink ../config/aria2.conf;
      ".rgignore".source = config.lib.file.mkOutOfStoreSymlink ../config/.rgignore;
      ".rules.verible_lint".source = config.lib.file.mkOutOfStoreSymlink ../config/.rules.verible_lint;
    };

    sessionVariables = {
      EDITOR = "nvim";
    };
    # need to do something about these things
    sessionPath = ["$HOME/.zvm/bin" "$HOME/.zvm/self" "$HOME/.local/bin" "$HOME/.cargo/bin"];
  };
  # ++ lib.optionals pkgs.stdenv.isLinux {
  #   username = "tony";
  #   homeDirectory = "/home/tony";
  # };
}
