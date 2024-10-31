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
      # config = {
      #   theme = "Catppuccin Mocha";
      # };
      # themes = {
      #   dracula = {
      #     src = pkgs.fetchFromGitHub {
      #       owner = "catppuccin";
      #       repo = "bat"; # Bat uses sublime syntax for its themes
      #       rev = "d3feec47b16a8e99eabb34cdfbaa115541d374fc";
      #       sha256 = "s0CHTihXlBMCKmbBBb8dUhfgOOQu9PBCQ+uviy7o47w=";
      #     };
      #     file = "themes/Catppuccin Mocha.tmTheme";
      #   };
      # };
    };
    zellij = {
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
      ouch
      miller
      autoconf
      hyperfine
      ffmpeg
      copier
      pre-commit
      exiftool

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

      ccache

      ### fun ###
      cmatrix

      ### system defaults ###
      nodejs_22
      python312
    ];
  };
}
