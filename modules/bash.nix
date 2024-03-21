{pkgs, ...}: {
  programs.bash = {
    enable = true;
    enableCompletion = true;
    initExtra = ''eval "$(starship init bash)"'';
  };
}
