{
  pkgs,
  config,
  lib,
  ...
}: {
  programs = {
    bun = {
      enable = true;
    };
    go = {
      enable = true;
      packages = {
      };
    };
    nnn = {
      enable = true;
      extraPackages = [];
      # package = pkgs.nnn.override {withNerdIcons = true;};
      plugins = {
        mappings = {
          d = "fzcd";
          # p = "preview-tui";
          f = "finder";
        };
      };
    };
    yazi = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableNushellIntegration = true;
      enableZshIntegration = true;
      # keymap = pkgs.lib.importTOML ../config/yazi/keymap.toml;
      # settings = pkgs.lib.importTOML ../config/yazi/yazi.toml;
      # theme = pkgs.lib.importTOML ../config/yazi/theme.toml;
    };
  };
  home = {
    packages = with pkgs; [
      ### move to hm ###
      ripgrep # recursively searches directories for a regex pattern
      aria2
      jq
      bat
      # zellij
      # helix
      htop
      # mpv
      # xonsh
      # luajit

      ### utils ###
      # coreutils
      file
      which
      tree
      rclone
      rsync
      # zip
      # xz
      # unzip
      # p7zip
      # gnused
      # gnutar
      gawk
      ouch
      notcurses
      miller
      # zstd
      # caddy
      # gnupg
      hyperfine
      ncdu
      # yq-go # yaml processer https://github.com/mikefarah/yq
      neofetch
      rmtrash
      gron
      ffmpeg
      flyctl

      ### android ###
      scrcpy

      ### gen ###
      ollama
      llama-cpp

      ### network ###
      # socat # replacement of openbsd-netcat
      curl
      wget
      dogdns
      nmap # A utility for network discovery and security auditing

      ### containers ###
      docker
      colima
      xquartz
      cachix

      ### gui apps ###
      # discord
      # vencord

      ### typesetting ###
      glow # markdown previewer in terminal
      typst
      hugo

      # anki-bin
      # obs-studio
      # obsidian
      # zed-editor
      # zoom-us
      sioyek

      copier
      pre-commit
      exiftool

      ### fun ###
      cmatrix
      cowsay
      # spotifyd

      ### hdl ###
      verilator
      verilog
      gtkwave
      # kicad
      logisim-evolution
      # wireshark
      # termshark
      ngspice
      # verible
      maven

      ### essentials ###
      rustup
      nodejs
      # nodejs_21
      # python312Full
      (python3.withPackages
        (p: [
          p.pip
        ]))
      pipx
      # ]
      # ++ lib.optionals pkgs.stdenv.isDarwin [
      #   (writeShellScriptBin "darwinix" ''
      #     darwin-rebuild switch --flake ~/.phoenix/
      #   '')
      # ]
      # ++ lib.optionals pkgs.stdenv.isLinux [
      #   (writeShellScriptBin "hmnix" ''
      #     home-manager switch --flake ~/.phoenix/home/
      #   '')
    ];

    # file = {
    #   ".rgignore".source = config.lib.file.mkOutOfStoreSymlink ../config/.rgignore;
    #   ".rules.verible_lint".source = config.lib.file.mkOutOfStoreSymlink ../config/.rules.verible_lint;
    # };
  };
}
