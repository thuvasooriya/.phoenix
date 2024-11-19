{
  pkgs,
  config,
  ...
}: {
  programs = {
    nushell = {
      enable = true;
      configFile.source = ../../../config/config.nu;
      extraConfig = ''
        let carapace_completer = {|spans|
        carapace $spans.0 nushell $spans | from json
        }
        $env.config = {
         show_banner: false,
         completions: {
         case_sensitive: false # case-sensitive completions
         quick: true    # set to false to prevent auto-selecting completions
         partial: true    # set to false to prevent partial filling of the prompt
         algorithm: "fuzzy"    # prefix or fuzzy
         external: {
             enable: true
             max_results: 100
             completer: $carapace_completer # check 'carapace_completer'
           }
         }
        }
        $env.PATH = ($env.PATH |
        split row (char esep) |
        prepend ${config.home.homeDirectory}/.apps |
        append /usr/bin/env
        )
      '';
      environmentVariables = {
        # EDITOR = "nvim";
      };

      shellAliases = {
        urldecode = "python3 -c 'import sys, urllib.parse as ul; print(ul.unquote_plus(sys.stdin.read()))'";
        urlencode = "python3 -c 'import sys, urllib.parse as ul; print(ul.quote_plus(sys.stdin.read()))'";
        nv = "nvim";
        vi = "nvim";
        vim = "nvim";
        # constar = "$EDITOR $HOME/.phoenix/config/starship.toml";
        cat = "bat";
        edsshgen = "ssh-keygen -t ed25519";
        ze = "zellij";
        spotx = "bash -c 'bash <(curl -sSL https://spotx-official.github.io/run.sh) -B -dh --installmac'";
        j = "just";
        # f = "find -type f -name";
      };
    };
  };
}
