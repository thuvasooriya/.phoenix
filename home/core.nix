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
      # package
      settings = {
        log = {
          enabled = false;
        };
        manager = {
          show_hidden = true;
          sort_by = "modified";
          sort_dir_first = true;
          sort_reverse = true;
        };
      };
      theme = {
        flavor = {
          use = "catppuccin-mocha";
        };
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
      };
    };

    skim = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
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

        ### utils ###
        # coreutils
        file
        which
        tree
        # zip
        # xz
        # unzip
        # p7zip
        # gnused
        # gnutar
        gawk
        # zstd
        # caddy
        # gnupg
        hyperfine
        # yq-go # yaml processer https://github.com/mikefarah/yq
        rsync
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

        ### fun ###
        cmatrix
        cowsay

        ### hdl ###
        verilator
        verilog
        gtkwave
        # verible

        ### essentials ###
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
        (writeShellScriptBin "hmnix" ''
          home-manager switch --flake ~/.phoenix/home/
        '')
      ];

    file = {
      ".rgignore".source = config.lib.file.mkOutOfStoreSymlink ../config/.rgignore;
      ".rules.verible_lint".source = config.lib.file.mkOutOfStoreSymlink ../config/.rules.verible_lint;
    };
  };
}
