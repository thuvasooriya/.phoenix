{username, ...}: {
  # import sub modules
  imports = [
    ./shell.nix
    ./core.nix
    ./fish.nix
    ./nvim.nix
    ./git.nix
    ./config.nix
  ];

  home = {
    username = username;
    homeDirectory = "/Users/${username}";
    stateVersion = "23.11";
  };
  programs.home-manager.enable = true;
}
