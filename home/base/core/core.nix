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
    yazi = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableNushellIntegration = true;
      enableZshIntegration = true;
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
      btop
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
      logisim-evolution
      wireshark
      ngspice
      verible
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
    ];

    file = {
      ".rgignore".source = config.lib.file.mkOutOfStoreSymlink ../config/.rgignore;
      ".rules.verible_lint".source = config.lib.file.mkOutOfStoreSymlink ../config/.rules.verible_lint;
    };
  };
}
