{
  pkgs,
  lib,
  ...
}: {
  # todo: write a script to check whether homebrew is installed and install it
  environment.systemPackages = with pkgs; [
    m-cli
  ];

  programs.zsh = {
    enable = true;
    shellInit = ''
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

  # programs.bash = {
  #   enable = true;
  #   initExtra = ''
  #     if [[ $(uname -m) == 'arm64' ]]; then
  #         eval "$(/opt/homebrew/bin/brew shellenv)"
  #     fi
  #   '';
  # };

  environment = {
    systemPath = [
      "$HOME/.zvm/bin"
      "$HOME/.zvm/self"
      "$GHOSTTY_BIN_DIR"
    ];
  };

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
    ];

    # `brew install --cask`
    casks = [
      ### dev ###
      "orbstack"
      "visual-studio-code"
      "zed"
      # "utm"
      "android-platform-tools"

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
      # "syncthing"
      "keka"
      # "raycast"
      # "loungy"
      "notion-calendar"
      "orion"
      # "spotube"
      # "arc"

      "inkscape"
      "obs"
      "zoom"
      # "blender"
      "handbrake"
    ];
  };
}
