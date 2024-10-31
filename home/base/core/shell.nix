{
  pkgs,
  config,
  ...
}: {
  programs = {
    zsh = {
      enable = true;
      enableCompletion = false;
      syntaxHighlighting.enable = true;
      history = {
        ignoreAllDups = true;
        ignoreDups = true;
      };
      antidote = {
        enable = true;
        plugins = [
          "jeffreytse/zsh-vi-mode"
          "romkatv/zsh-bench kind:path"
          "olets/zsh-abbr kind:defer"
          "mattmc3/zfunctions"
          "mattmc3/ez-compinit"
          "zsh-users/zsh-completions kind:fpath path:src"
          "zsh-users/zsh-autosuggestions"
          "zdharma-continuum/fast-syntax-highlighting kind:defer"
          "zsh-users/zsh-history-substring-search"
          "romkatv/powerlevel10k"
        ];
      };
      initExtraFirst = ''
        source "${config.home.homeDirectory}/.phoenix/config/zsh/initExtraFirst.zsh"
      '';
      initExtra = ''
        source "${config.home.homeDirectory}/.phoenix/config/zsh/aliases.zsh"
        source "${config.home.homeDirectory}/.phoenix/config/zsh/initExtra.zsh"
      '';
    };
    nushell.enable = true;
    starship = {
      enable = true;
      enableZshIntegration = false;
      enableBashIntegration = false;
      enableNushellIntegration = true;
      enableTransience = true;
      settings = pkgs.lib.importTOML ../../../config/starship.toml;
    };
    zoxide = {
      enable = true;
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
      enableNushellIntegration = true;
      enableZshIntegration = true;
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    fzf = {
      enable = true;
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
    ze = "zellij";
    # a = "python3 ~/.config/aria2/aria2.py";
    v = "nvim";
    vi = "nvim";
    vim = "nvim";
    spotx = "bash -c 'bash <(curl -sSL https://spotx-official.github.io/run.sh) -B -dh --installmac'";
    j = "just";
    f = "find -type f -name";
  };
}
