# args @ {
{pkgs, ...}: {
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
      shellAliases = {
        # ze = "zellij";
        # a = "python3 ~/.config/aria2/aria2.py";
        # v = "nvim";
        nv = "nvim";
        constar = "$EDITOR $HOME/.phoenix/config/starship.toml";
      };
      shellAbbrs = {
        sshkey-ed255 = "ssh-keygen -t ed25519";
        # ip = "ipconfig getifaddr en0";
        # dx = "darwinix";
        omnetpp = "opp_env run omnetpp-latest -c omnetpp";
        cd = "z";
        cat = "bat";
      };
      plugins = with pkgs.fishPlugins; [
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
        iv = {
          body = ''
            set output_file (string split -m 1 '.' $argv[1])[1]".o"
            iverilog -Wall -o $output_file $argv >/tmp/iver.out 2>&1
            or return $status

            if string match -r "VCD info" </tmp/iver.out
                vvp $output_file
                gtkwave
            else
                echo "No VCD info found in the output."
            end
          '';
        };
      };
    };
  };
}
