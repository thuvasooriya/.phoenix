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
        ];
      };
      # initExtraFirst = ''
      #   source "${config.home.homeDirectory}/.phoenix/config/zsh/initExtraFirst.zsh"
      # source "${config.home.homeDirectory}/.phoenix/config/zsh/initExtra.zsh"
      # '';
      initExtra = ''
        source "${config.home.homeDirectory}/.phoenix/config/zsh/aliases.zsh"
      '';
    };
  };
}
