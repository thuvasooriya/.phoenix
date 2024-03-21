args @ {
  pkgs,
  lib,
  ...
}: {
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
    settings = pkgs.lib.importTOML ../config/starship.toml;
  };

  programs.zoxide.enable = true;
  programs.zoxide.enableFishIntegration = true;

  programs.fish = {
    enable = true;
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
        # bind -m default jk commandline -f repaint
        # bind -m default jj commandline -f repaint
        bind -M insert -m default jk backward-char force-repaint
        bind -M insert -m default jj backward-char force-repaint
      '';
      gitignore = "curl -sL https://www.gitignore.io/api/$argv";
    };
    shellInit = ''
      set -g fish_greeting
      starship init fish | source
      enable_transience
    '';
    interactiveShellInit = ''
    '';
    loginShellInit = ''
    '';
    shellAliases = {
      bubu = "brew update && brew upgrade";
      broom = "brew autoremove && brew cleanup";
      pact = "source ./.venv/bin/activate.fish";
      pen = "python3 -m venv .venv";
      # fishpaths = "echo (set_color green)$fish_user_paths(set_color normal)";
      # confish = "nvim $HOME/.config/fish/config.fish";
      # constar "code $HOME/.config/starship.toml"
    };
    shellAbbrs = {
      ssh-keygen-ed25519 = "ssh-keygen -t ed25519";
      ip = "ipconfig getifaddr en0";
      d = "aria2c -x8";
      yt = "yt-dlp";
      omnetpp = "opp_env run omnetpp-latest -c omnetpp";
    };
    plugins = with pkgs.fishPlugins; [
      # {
      #   name = "plugin-git"; # git abbrs
      #   #src = plugin-git.src;
      #   src = pkgs.fetchFromGitHub { # https://github.com/jhillyerd/plugin-git/pull/103
      #     owner = "hexclover";
      #     repo = "plugin-git";
      #     rev = "master";
      #     sha256 = "sha256-efKPbsXxjHm1wVWPJCV8teG4DgZN5dshEzX8PWuhKo4";
      #   };
      # }
      # {
      #  name = "done"; # doesn't work on wayland
      #  src = done.src;
      # }
      # {
      #  name = "async-prompt"; # pisces # auto pairing of ([{"'
      #  src = async-prompt.src;
      # }
    ];
  };
}
# ${lib.optionalString (!args ? osConfig) "source ${pkgs.nix}/etc/profile.d/nix-daemon.fish"}

