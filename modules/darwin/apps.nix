{
  pkgs,
  lib,
  ...
}: {
  environment.systemPackages = with pkgs; [
    m-cli
  ];

  environment = {
    systemPath = [
      "$HOME/.zvm/bin"
      "$HOME/.zvm/self"
    ];
  };

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
      "curl"
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
      "wireshark"
      # "ngspice"
      # "digital"

      ### social ###
      "telegram"
      "whatsapp"
      "discord"

      ### utils ###
      "keyclu"
      "notion-calendar"
      "obsidian"
      "orion"
      # "syncthing"
      # "spotube"
      # "arc"
      "obs"
      "zoom"
      "keka"
      "macwhisper"
      # "loungy"
      # "raycast"
      # "blender"
      "handbrake"
      # "utm"
    ];
  };
}
