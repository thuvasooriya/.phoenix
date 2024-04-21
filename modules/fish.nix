args @ {
  pkgs,
  lib,
  ...
}: {
  programs.fish = {
    enable = true;
    functions = {
      starship_transient_prompt_func.body = ''
        starship module line_break
        starship module character
      '';
      starship_transient_rprompt_func.body = ''
        starship module time
        starship module directory
      '';
      fish_user_key_bindings.body = ''
        fish_vi_key_bindings
        bind -M insert -m default jk backward-char force-repaint
        bind -M insert -m default jj backward-char force-repaint
      '';
      gitignore = "curl -sL https://www.gitignore.io/api/$argv";
      zr = {
        body = ''
          set file_dir (dirname $argv)
          set file_name (basename $argv)
          set file_extension (string split "." $file_name)[-1]
          set file_tag (string replace ".$file_extension" "" $file_name)
          set out_file "$file_dir/$file_tag.o"

          switch $file_extension
              case c
                  echo (set_color -o yellow)"processing c"(set_color normal)
                  zig cc $argv -o $out_file
                  if test $status -ne 0
                      echo (set_color -o red)"Error: Compilation failed for $out_file."(set_color normal)
                      rm -f $out_file
                      return 1
                  end
                  echo (set_color -o green)"compiled: $out_file"(set_color normal)
                  echo (set_color -o yellow)"running..."(set_color normal)
                  echo ""
                  "./$out_file"
              case cpp
                  echo (set_color -o yellow)"processing c++"(set_color normal)
                  zig c++ $argv -o $out_file
                  if test $status -ne 0
                      echo (set_color -o red)"Error: Compilation failed for $out_file."(set_color normal)
                      rm -f $out_file
                      return 1
                  end
                  echo (set_color -o green)"compiled: $out_file"(set_color normal)
                  echo (set_color -o yellow)"running..."(set_color normal)
                  echo ""
                  "./$out_file"
              case zig
                  echo (set_color -o yellow)"⚡️ziggin"(set_color normal)
                  zig run $argv
                  echo ""
              case '*'
                  echo (set_color -o red)"Error: file type:'$file_extension' Invalid file extension."(set_color normal)
                  return 1
          end
        '';
        # argument = file_path;
      };
    };
    shellInit = ''
      set -g fish_greeting
      starship init fish | source
    '';
    interactiveShellInit = ''
    '';
    loginShellInit = ''
    '';
    shellAliases = {
      # cd = "z";
      bubu = "brew update && brew upgrade";
      broom = "brew autoremove && brew cleanup";
      ls = "lsd -Alt --date relative";
      rm = "rmtrash";
      ze = "zellij";
      # python3 = "python";
      pact = "source ./.venv/bin/activate.fish";
      pen = "python -m venv .venv";
      d = "aria2c -x8";
      n = "nvim";
      # fishpaths = "echo (set_color green)$fish_user_paths(set_color normal)";
      # confish = "nvim $HOME/.config/fish/config.fish";
      # constar "code $HOME/.config/starship.toml"
    };
    shellAbbrs = {
      sshkey-ed255 = "ssh-keygen -t ed25519";
      ip = "ipconfig getifaddr en0";
      yt = "yt-dlp";
      omnetpp = "opp_env run omnetpp-latest -c omnetpp";
    };
    plugins = with pkgs.fishPlugins; [
      # {
      #   name = "plugin-git"; # git abbrs
      #   #src = plugin-git.src;
      #   src = pkgs.fetchFromGitHub { # https://github.com/jhillyerd/plugin-git/pull/103
      #     owner = "hexclover";
      #     repo = "plugin-git";
      #     rev = "master";
      #     sha256 = "sha256-efKPbsXxjHm1wVWPJCV8teG4DgZN5dshEzX8PWuhKo4";
      #   };
      # }
      # {
      #  name = "done"; # doesn't work on wayland
      #  src = done.src;
      # }
      # {
      #  name = "async-prompt"; # pisces # auto pairing of ([{"'
      #  src = async-prompt.src;
      # }
    ];
  };
}
# ${lib.optionalString (!args ? osConfig) "source ${pkgs.nix}/etc/profile.d/nix-daemon.fish"}

