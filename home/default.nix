{username, ...}: {
  # import sub modules
  imports = [
    ./fish.nix
    ./nvim.nix
    ./git.nix
    ./config.nix
    ./shell.nix
    ./core.nix
  ];

  home = {
    username = username;
    homeDirectory = "/Users/${username}";
    stateVersion = "23.11";
  };

  programs.home-manager.enable = true;
}
