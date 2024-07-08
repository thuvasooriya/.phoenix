{pkgs, ...}: {
  programs = {
    zsh = {
      enable = true;
      enableCompletion = true;
      # bashrcExtra = ''
      #   export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/.cargo/bin"
      # '';
    };
    nushell.enable = true;
    starship = {
      enable = true;
      enableZshIntegration = true;
      enableFishIntegration = true;
      enableBashIntegration = true;
      enableNushellIntegration = true;
      enableTransience = true;
      settings = pkgs.lib.importTOML ../config/starship.toml;
    };
    zoxide = {
      enable = true;
      enableFishIntegration = true;
    };
    lsd = {
      enable = true;
      colors = {
        # size = {
        #   large = "dark_yellow";
        #   none = "grey";
        #   small = "yellow";
        # };
      };
      enableAliases = true;
      settings = {
        date = "relative";
        ignore-globs = [
          ".git"
          ".hg"
        ];
      };
    };
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    # nix-index = {
    #   enable = true;
    #   enableFishIntegration = true;
    # };
    # man = {
    #   enable = true;
    #   generateCaches = true;
    # };
    fzf = {
      enable = true;
      enableFishIntegration = true;
    };
    keychain = {
      enable = true;
      enableFishIntegration = true;
      keys = ["id_ed25519"];
      # agents = [];
    };
  };

  home.shellAliases = {
    urldecode = "python3 -c 'import sys, urllib.parse as ul; print(ul.unquote_plus(sys.stdin.read()))'";
    urlencode = "python3 -c 'import sys, urllib.parse as ul; print(ul.quote_plus(sys.stdin.read()))'";
  };
}
