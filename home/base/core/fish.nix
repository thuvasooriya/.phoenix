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
      # loginShellInit = ''
      # '';
      # shellAbbrs = {
      # };
      # plugins = with pkgs.fishPlugins; [
      # ];
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
        #   gig = "curl -sL https://www.gitignore.io/api/$argv";
        #   pact = {
        #     body = ''
        #       if test (count $argv) -eq 0
        #           set venv_path ".venv/bin/activate.fish"
        #       else
        #           set venv_path "$argv[1]/bin/activate.fish"
        #       end
        #
        #       if test -f $venv_path
        #           source $venv_path
        #       else
        #           echo "venv not found at $venv_path"
        #       end
        #     '';
        #   };
        #   pen = {
        #     body = ''
        #       if test (count $argv) -eq 0
        #           set venv_path ".venv"
        #       else
        #           set venv_path "$argv[1]"
        #           echo "creating and activating at $argv[1]"
        #       end
        #
        #       python -m venv $venv_path
        #       source "$venv_path/bin/activate.fish"
        #     '';
        #   };
      };
    };
  };
}
