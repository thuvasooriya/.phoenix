{
  pkgs,
  config,
  ...
}: {
  programs = {
    starship = {
      enable = true;
      enableZshIntegration = true;
      enableBashIntegration = true;
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
    carapace = {
      enable = true;
      enableZshIntegration = true;
      enableNushellIntegration = true;
    };
  };
  home.shellAliases = {
    urldecode = "python3 -c 'import sys, urllib.parse as ul; print(ul.unquote_plus(sys.stdin.read()))'";
    urlencode = "python3 -c 'import sys, urllib.parse as ul; print(ul.quote_plus(sys.stdin.read()))'";
    nv = "nvim";
    constar = "$EDITOR $HOME/.phoenix/config/starship.toml";
    cat = "bat";
    edsshgen = "ssh-keygen -t ed25519";
    ze = "zellij";
    # v = "nvim";
    # vi = "nvim";
    # vim = "nvim";
    spotx = "bash -c 'bash <(curl -sSL https://spotx-official.github.io/run.sh) -B -dh --installmac'";
    j = "just";
    f = "find -type f -name";
  };
  home.sessionPath = [
    "$HOME/.local/bin"
    "$HOME/.zvm/bin"
    "$HOME/.zvm/self"
    "$GHOSTTY_BIN_DIR"
    "$HOME/.bun/bin"
    "$HOME/.cargo/bin"
    "$HOME/.luarocks/bin"
    "$HOME/.pixi/bin"
  ];
}
