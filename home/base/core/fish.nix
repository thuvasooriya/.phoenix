{
  pkgs,
  config,
  ...
}: {
  programs = {
    fish = {
      enable = true;
      # shellInit = ''
      # '';
      # interactiveShellInit = ''
      # '';
      # shellInitLast = ''
      # '';
      loginShellInit = ''
        set -U fish_greeting
        set fish_vi_force_cursor 1
        if set -q GHOSTTY_RESOURCES_DIR
            source "$GHOSTTY_RESOURCES_DIR/shell-integration/fish/vendor_conf.d/ghostty-shell-integration.fish"
        end
      '';
      # shellAbbrs = {
      # };
      plugins = [
        {
          name = "fish-fzf";
          src = pkgs.fetchFromGitHub {
            owner = "jethrokuan";
            repo = "fzf";
            rev = "24f4739fc1dffafcc0da3ccfbbd14d9c7d31827a";
            sha256 = "0kz057nr07ybh0y06ww3p424rgk8pi84pnch9jzb040qqn9a8823";
          };
        }
        {
          name = "autopair";
          src = pkgs.fetchFromGitHub {
            owner = "jorgebucaran";
            repo = "autopair.fish";
            rev = "1.0.4";
            sha256 = "sha256-s1o188TlwpUQEN3X5MxUlD/2CFCpEkWu83U9O+wg3VU=";
          };
        }
        {
          name = "fish-you-should-use";
          src = pkgs.fetchFromGitHub {
            owner = "paysonwallach";
            repo = "fish-you-should-use";
            rev = "a332823512c0b51e71516ebb8341db0528c87926";
            hash = "sha256-MmGDFTgxEFgHdX95OjH3jKsVG1hdwo6bRht+Lvvqe5Y=";
          };
        }
      ];
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
        gig = "curl -sL https://www.gitignore.io/api/$argv";
        pact = {
          body = ''
            if test (count $argv) -eq 0
                set venv_path ".venv/bin/activate.fish"
            else
                set venv_path "$argv[1]/bin/activate.fish"
            end

            if test -f $venv_path
                source $venv_path
            else
                echo "venv not found at $venv_path"
            end
          '';
        };
        pen = {
          body = ''
            if test (count $argv) -eq 0
                set venv_path ".venv"
            else
                set venv_path "$argv[1]"
                echo "creating and activating at $argv[1]"
            end

            python -m venv $venv_path
            source "$venv_path/bin/activate.fish"
          '';
        };
      };
    };
  };
}
