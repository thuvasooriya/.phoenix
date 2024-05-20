{
  pkgs,
  outputs,
  config,
  inputs,
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
        # "https://pkg.go.dev/github.com/yuin/goldmark" = builtins.fetchGit "https://github.com/yuin/goldmark";
      };
    };
    # modern vim
    # neovim = {
    #   enable = true;
    #   defaultEditor = true;
    #   vimAlias = true;
    # };
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
    yazi = {
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableNushellIntegration = true;
      enable = true;
      enableZshIntegration = true;
      # keymap = {
      #   input.keymap = [
      #     {
      #       exec = "close";
      #       on = [""];
      #     }
      #     {
      #       exec = "close --submit";
      #       on = [""];
      #     }
      #     {
      #       exec = "escape";
      #       on = [""];
      #     }
      #     {
      #       exec = "backspace";
      #       on = [""];
      #     }
      #   ];
      #   manager.keymap = [
      #     {
      #       exec = "escape";
      #       on = [""];
      #     }
      #     {
      #       exec = "quit";
      #       on = ["q"];
      #     }
      #     {
      #       exec = "close";
      #       on = [""];
      #     }
      #   ];
      # };
      # # package
      # settings = {
      #   log = {
      #     enabled = false;
      #   };
      #   manager = {
      #     show_hidden = false;
      #     sort_by = "modified";
      #     sort_dir_first = true;
      #     sort_reverse = true;
      #   };
      # };
      # theme = {
      #   filetype = {
      #     rules = [
      #       {
      #         fg = "#7AD9E5";
      #         mime = "image/*";
      #       }
      #       {
      #         fg = "#F3D398";
      #         mime = "video/*";
      #       }
      #       {
      #         fg = "#F3D398";
      #         mime = "audio/*";
      #       }
      #       {
      #         fg = "#CD9EFC";
      #         mime = "application/x-bzip";
      #       }
      #     ];
      #   };
      # };
    };

    # skim provides a single executable: sk.
    # Basically anywhere you would want to use grep, try sk instead.
    skim = {
      enable = true;
      enableBashIntegration = true;
    };
  };
  home = {
    packages = with pkgs;
      [
        ### move to hm ###
        ripgrep # recursively searches directories for a regex pattern
        aria2
        jq
        bat
        zellij
        htop
        # xonsh
        # luajit

        ### file managers ###
        # nnn # terminal file manager configured in hm
        # yazi # terminal file manager configured in hm

        ### archives ###
        # zip
        # xz
        # unzip
        # p7zip

        ### utils ###
        # coreutils
        hyperfine
        # yq-go # yaml processer https://github.com/mikefarah/yq
        # fzf # A command-line fuzzy finder
        curl
        wget
        rsync
        neofetch
        rmtrash
        dogdns
        gron
        ffmpeg

        scrcpy

        ollama
        llama-cpp

        # socat # replacement of openbsd-netcat
        nmap # A utility for network discovery and security auditing

        docker
        colima
        xquartz

        # discord
        # vencord

        flyctl

        # misc
        # file
        # which
        # tree
        # gnused
        # gnutar
        # gawk
        # zstd
        # caddy
        # gnupg

        ### productivity ###
        glow # markdown previewer in terminal
        typst

        ### fun ###
        cmatrix
        cowsay

        # # digital design
        # verilator
        # verilog
        # gtkwave
        # verible
        hugo
        nodejs

        # nodejs_21
        (python3.withPackages
          (p: [
            p.pip
          ]))
        pipx
      ]
      ++ lib.optionals pkgs.stdenv.isDarwin [
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
  };
}
