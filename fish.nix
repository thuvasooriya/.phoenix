args @ {pkgs, lib, ...}: {

  programs.starship = {
      enable = true;
      settings = pkgs.lib.importTOML ./starship.toml;
    };
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
      # _tide_item_nix_shell = { # displays nix shell env on the right of the prompt
      #   body = ''
      #     # mostly a babelfish conversion of nix-shell-info from any-nix-shell
      #     # relies on the nix wrapper from any-nix-shell
      #
      #     if set -q IN_NIX_SHELL || set -q IN_NIX_RUN
      #       set output (echo $ANY_NIX_SHELL_PKGS | xargs | string collect; or echo)
      #       if test -n "$name" && test "$name" != 'shell'
      #         set -a output ' '"$name"
      #       end
      #       if test -n "$output"
      #         set output (echo $output $additional_pkgs | tr ' ' '\\n' | sort -u | tr '\\n' ' ' | xargs | string collect; or echo)
      #         _tide_print_item nix_shell $tide_nix_shell_icon' ' $output
      #       else
      #         _tide_print_item nix_shell $tide_nix_shell_icon' [unknown environment]' 
      #       end
      #     end
      #   '';
      # };
    };
    # shellInit = ''
    #   ${lib.optionalString (!args ? osConfig) "source ${pkgs.nix}/etc/profile.d/nix-daemon.fish"}
    # '';
    interactiveShellInit = ''
      set -g fish_greeting
      starship init fish | source
      enable_transience
    '';
    loginShellInit = ''
      set -g fish_greeting
    '';
    shellAliases = {
      # bubu = "brew update && brew upgrade";
      # broom = "brew autoremove && brew cleanup";
      fishpaths = "echo (set_color green)$fish_user_paths(set_color normal)";
      # confish = "nvim $HOME/.config/fish/config.fish";
      # constar "code $HOME/.config/starship.toml"
      # icat = "kitty +kitten icat";
    };
    shellAbbrs = {
      ssh-keygen-ed25519 = "ssh-keygen -t ed25519";
      ip = "ipconfig getifaddr en0";
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
