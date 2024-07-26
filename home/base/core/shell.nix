{pkgs, ...}: {
  programs = {
    zsh = {
      enable = true;
      autocd = true;
      enableCompletion = true;
    };
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
      shellAbbrs = {
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
    nushell.enable = true;
    starship = {
      enable = true;
      enableZshIntegration = true;
      enableFishIntegration = true;
      enableBashIntegration = true;
      enableNushellIntegration = true;
      enableTransience = true;
      settings = pkgs.lib.importTOML ../../../config/starship.toml;
    };
    zoxide = {
      enable = true;
      enableFishIntegration = true;
      enableZshIntegration = true;
      enableBashIntegration = true;
      enableNushellIntegration = true;
    };
    lsd = {
      enable = true;
      enableAliases = true;
      settings = {
        date = "relative";
        ignore-globs = [
          ".git"
          ".hg"
        ];
      };
    };
    yazi = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableNushellIntegration = true;
      enableZshIntegration = true;
    };
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    fzf = {
      enable = true;
      enableFishIntegration = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
    };
    keychain = {
      enable = true;
      enableFishIntegration = true;
      keys = ["id_ed25519"];
      # agents = [];
    };
    ripgrep = {
      enable = true;
    };
  };

  home.shellAliases = {
    urldecode = "python3 -c 'import sys, urllib.parse as ul; print(ul.unquote_plus(sys.stdin.read()))'";
    urlencode = "python3 -c 'import sys, urllib.parse as ul; print(ul.quote_plus(sys.stdin.read()))'";
    nv = "nvim";
    constar = "$EDITOR $HOME/.phoenix/config/starship.toml";
    cat = "bat";
    edsshgen = "ssh-keygen -t ed25519";
    # omnetpp = "opp_env run omnetpp-latest -c omnetpp";
    # ze = "zellij";
    # a = "python3 ~/.config/aria2/aria2.py";
    v = "nvim";
    vi = "nvim";
    vim = "nvim";
    spotx = "bash -c 'bash <(curl -sSL https://spotx-official.github.io/run.sh) -B -dh --installmac'";
    j = "just";
  };
}
