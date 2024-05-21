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
      keymap = pkgs.lib.importTOML ../config/yazi/keymap.toml;
      # keymap = {
      #   # input.keymap = [
      #   # ];
      #   # manager.keymap = [
      #   # ];
      #   manager.prepend_keymap = [
      #     {
      #       on = ["u" "a"];
      #       run = "plugin bookmarks-persistence --args=save";
      #       desc = "Save current position as a bookmark";
      #     }
      #     {
      #       on = ["u" "g"];
      #       run = "plugin bookmarks-persistence --args=jump";
      #       desc = "Jump to a bookmark";
      #     }
      #     {
      #       on = ["u" "d"];
      #       run = "plugin bookmarks-persistence --args=delete";
      #       desc = "Delete a bookmark";
      #     }
      #     {
      #       on = ["u" "D"];
      #       run = "plugin bookmarks-persistence --args=delete_all";
      #       desc = "Delete all bookmarks";
      #     }
      #   ];
      # };
      # package
      settings = pkgs.lib.importTOML ../config/yazi/yazi.toml;
      # settings = {
      #   log = {
      #     enabled = false;
      #   };
      #   manager = {
      #     ratio = [2 3 3];
      #     show_hidden = false;
      #     sort_by = "modified";
      #     sort_dir_first = true;
      #     sort_reverse = true;
      #   };
      #   plugin = {
      #     prepend_previewers = [
      #       {
      #         name = "*.md";
      #         run = "glow";
      #       }
      #       {
      #         mime = "text/csv";
      #         run = "miller";
      #       }
      #       {
      #         mime = "application/*zip";
      #         run = "ouch";
      #       }
      #       {
      #         mime = "application/x-tar";
      #         run = "ouch";
      #       }
      #       {
      #         mime = "application/x-bzip2";
      #         run = "ouch";
      #       }
      #       {
      #         mime = "application/x-7z-compressed";
      #         run = "ouch";
      #       }
      #       {
      #         mime = "application/x-rar";
      #         run = "ouch";
      #       }
      #       {
      #         mime = "application/x-xz";
      #         run = "ouch";
      #       }
      #     ];
      #   };
      # };
      theme = pkgs.lib.importTOML ../config/yazi/theme.toml;
      # theme = {
      #   flavor = {
      #     use = "catppuccin-mocha";
      #   };
      #   #   filetype = {
      #   #     rules = [
      #   #       {
      #   #         fg = "#7AD9E5";
      #   #         mime = "image/*";
      #   #       }
      #   #       {
      #   #         fg = "#F3D398";
      #   #         mime = "video/*";
      #   #       }
      #   #       {
      #   #         fg = "#F3D398";
      #   #         mime = "audio/*";
      #   #       }
      #   #       {
      #   #         fg = "#CD9EFC";
      #   #         mime = "application/x-bzip";
      #   #       }
      #   #     ];
      # };
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
        ouch
        miller
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

        # anki-bin
        # obs-studio
        # obsidian
        # zed-editor
        # zoom-us
        skimpdf

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
        wireshark
        termshark
        ngspice
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
