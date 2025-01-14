{
  pkgs,
  config,
  lib,
  ...
}: {
  programs = {
    btop = {
      enable = true;
      settings = {
        color_theme = "catppuccin_mocha";
        vim_keys = true;
      };
    };
    jq = {
      enable = true;
    };
    bat = {
      enable = true;
      config = {
        theme = "catppuccin_mocha";
      };
    };
    zellij = {
      enable = true;
    };
    direnv = {
      enable = true;
      config = {
        whitelist = {
          prefix = [
            "$HOME/dev"
          ];
          exact = ["$HOME/.envrc"];
        };
      };
      nix-direnv.enable = true;
    };
    fzf = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
    };
    keychain = {
      enable = true;
      # enableFishIntegration = true;
      keys = ["id_ed25519"];
    };
    ripgrep = {
      enable = true;
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
      gawk
      autoconf
      hyperfine
      ffmpeg
      copier
      pre-commit
      exiftool
      caligula
      jujutsu

      ### network ###
      # socat # replacement of openbsd-netcat
      # curl
      wget
      dogdns
      nmap # A utility for network discovery and security auditing
      aria2

      ### containers ###
      docker
      cachix

      # clang
      ccache
      # cmake

      ### fun ###
      cmatrix

      ### system defaults ###
      nodejs
      python312
    ];
  };
}
