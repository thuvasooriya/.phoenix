{
  pkgs,
  config,
  lib,
  ...
}: {
  programs = {
    aria2 = {
      enable = true;
    };
    htop = {
      enable = true;
    };
    # btop = {
    #   enable = true;
    # };
    jq = {
      enable = true;
    };
    bat = {
      enable = true;
    };
    zellij = {
      enable = false;
      enableFishIntegration = true;
      enableZshIntegration = true;
      enableBashIntegration = true;
    };
  };
  home = {
    packages = with pkgs; [
      ### utils ###
      coreutils
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
      miller
      # zstd
      # caddy
      # gnupg
      hyperfine
      ncdu
      neofetch
      rmtrash
      gron
      ffmpeg

      ### network ###
      # socat # replacement of openbsd-netcat
      curl
      wget
      dogdns
      nmap # A utility for network discovery and security auditing

      ### containers ###
      docker
      cachix

      copier
      pre-commit
      exiftool

      ### fun ###
      cmatrix
      cowsay

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
  };
}
