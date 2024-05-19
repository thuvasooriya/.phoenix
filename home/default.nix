{username, ...}: {
  # import sub modules
  imports = [
    ./shell.nix
    ./core.nix
    ./git.nix
  ];

  home = {
    username = username;
    homeDirectory = "/Users/${username}";
    stateVersion = "23.11";
  };
  programs.home-manager.enable = true;
}
