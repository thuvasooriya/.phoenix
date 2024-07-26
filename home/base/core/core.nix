{
  pkgs,
  config,
  lib,
  ...
}: {
  programs = {
    htop = {
      enable = true;
    };
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
    activation = {
      bun_install = lib.hm.dag.entryAfter ["installPackages"] ''
        PATH="${config.home.path}/bin:$PATH"
        BUN_PATH="$HOME/.bun/bin/bun"

        if [ -x "$BUN_PATH" ]; then
          echo "bun found at $BUN_PATH"
          if "$BUN_PATH" --version &>/dev/null; then
            echo "bun is installed and functional"
          fi
        else
          echo "bun not found or not working. installing..."
          curl -fsSL https://bun.sh/install | bash
          echo "bun installed"
        fi
      '';
    };
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
      aria2

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
      go
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
