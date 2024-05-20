# args @ {
{pkgs, ...}: {
  programs = {
    fish = {
      enable = true;
      # shellInit = ''
      #   set fish_greeting
      # '';
      # interactiveShellInit = ''
      # '';
      # shellInitLast = ''
      # '';
      loginShellInit = ''
        set fish_greeting
      '';
      shellAliases = {
        # cd = "z";
        bubu = "brew update && brew upgrade";
        broom = "brew autoremove && brew cleanup";
        # ls = "lsd -Alt --date relative";
        # rm = "rmtrash";
        ze = "zellij";
        # python3 = "python";
        pact = "source ./.venv/bin/activate.fish";
        pen = "python -m venv .venv && pact";
        a = "python3 ~/.config/aria2/aria2.py";
        n = "nnn";
        v = "nvim";
        nv = "nvim";
        # fishpaths = "echo (set_color green)$fish_user_paths(set_color normal)";
        constar = "$EDITOR $HOME/.phoenix/config/starship.toml";
      };
      shellAbbrs = {
        sshkey-ed255 = "ssh-keygen -t ed25519";
        ip = "ipconfig getifaddr en0";
        yt = "yt-dlp";
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
# ${lib.optionalString (!args ? osConfig) "source ${pkgs.nix}/etc/profile.d/nix-daemon.fish"}

