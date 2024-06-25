{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    neovim
    git
    just
  ];

  ## todo: ghostty terminfo config for sbcs
  # TERMINFO_DIRS = "${pkgs.kitty.terminfo.outPath}/share/terminfo";
  environment = {
    variables.EDITOR = "nvim";
    shells = [pkgs.bashInteractive pkgs.zsh pkgs.fish];
    pathsToLink = [];
    systemPath = [
      "$HOME/.local/bin"
      "$HOME/.bun/bin"
      "$HOME/.cargo/bin"
      "$HOME/.zvm/bin"
      "$HOME/.zvm/self"
    ];
  };
  # services.karabiner-elements.enable = true;
  # programs.nix-index.enable = true;
  # programs.man.enable = true;
  programs.zsh = {
    enable = true;
    # enableFzfCompletion = true;
    # enableFzfGit = true;
    # enableFzfHistory = true;
    enableSyntaxHighlighting = true;
    loginShellInit = ''
      if [[ $(uname -m) == 'arm64' ]]; then
          eval "$(/opt/homebrew/bin/brew shellenv)"
      fi
    '';
  };
  programs.fish = {
    enable = true;
    shellInit = ''
      set fish_greeting
      if test (uname -m) = "arm64"
          eval (/opt/homebrew/bin/brew shellenv)
      end
    '';
  };
  programs.bash = {
    enable = true;
    enableCompletion = true;
  };

  # todo: write a script to check whether homebrew is installed and install it
  homebrew = {
    enable = true;
    # brewPrefix = "/opt/homebrew";
    onActivation = {
      autoUpdate = false;
      # 'zap': uninstalls all formulae(and related files) not listed here.
      # upgrade = true;
      cleanup = "zap";
    };

    # applications to install from mac app store using mas.
    # you need to install all these apps manually first so that your apple account have records for them.
    # otherwise apple store will refuse to install them.
    # for details, see https://github.com/mas-cli/mas
    masApps = {
      # Xcode = 497799835;
      # QQMusic = 595615424;
    };
    global = {brewfile = true;};

    taps = [
      # "homebrew/cask-fonts"
      # "homebrew/services"
      # "homebrew/cask-versions"
      # "krtirtho/apps"
      # "mongodb/brew"
    ];

    # `brew install`
    brews = [
      # "latexindent"
      # "octave"
      # "mongodb-community@7.0"
      # "curl" # no not install curl via nixpkgs, it's not working well on macOS!
      # "httpie" # http client
    ];

    # `brew install --cask`
    casks = [
      ### dev ###
      "orbstack"
      "visual-studio-code"
      "zed"
      # "ava"
      # "amethyst"

      "android-platform-tools"
      "cloudflare-warp"

      ### hdl ###
      "ltspice"
      # "wireshark"
      # "kicad"
      # "ngspice"
      # "digital"

      ### social ###
      "telegram"
      "whatsapp"
      "discord"

      ### utils ###
      "keyclu"
      # "notion"
      "notion-calendar"
      "obsidian"
      "orion"
      # "syncthing"
      # "spotube"
      # "arc"
      "obs"
      "zoom"
      "keka"
      # "selfcontrol"
      "loungy"
      # "raycast"
      "anki"
      # "blender"
      "handbrake"
      # "utm"
      # "iina" # video player
      # "stats" # beautiful system monitor
      # "insomnia" # REST client
    ];
  };
}
