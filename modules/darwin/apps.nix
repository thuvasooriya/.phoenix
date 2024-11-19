{
  pkgs,
  lib,
  ...
}: {
  environment.systemPackages = with pkgs; [
    m-cli
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = false;
  };

  # environment = {
  #   systemPath = [
  #     "$HOME/.local/bin"
  #     "$HOME/.zvm/bin"
  #     "$HOME/.zvm/self"
  #     "$GHOSTTY_BIN_DIR"
  #     "$HOME/.bun/bin"
  #     "$HOME/.cargo/bin"
  #     "$HOME/.luarocks/bin"
  #     "$HOME/.pixi/bin"
  #   ];
  #   # shells = [
  #   #   pkgs.zsh
  #   # ];
  #   # shellInit = ''
  #   #   eval "$(/opt/homebrew/bin/brew shellenv)"
  #   # '';
  # };
  # TODO: homebrew management script for initial installation

  homebrew = {
    enable = false;
    # brewPrefix = "/opt/homebrew/bin";
    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "zap";
    };
    global = {brewfile = true;};

    # applications to install from mac app store using mas.
    # you need to install all these apps manually first so that your apple account have records for them.
    # otherwise apple store will refuse to install them.
    # for details, see https://github.com/mas-cli/mas
    masApps = {
      # Xcode = 497799835;
    };

    taps = [
      # "mongodb/brew"
      # "osrf/simulation"
    ];

    # `brew install`
    brews = [
      # "latexindent"
      # "octave"
      "curl"
      # "gazebo11"
      # "gz-harmonic"
    ];

    # `brew install --cask`
    casks = [
      ### dev ###
      "orbstack"
      "visual-studio-code"
      "zed"
      # "utm"
      "android-platform-tools"

      # "ltspice"
      # "wireshark"
      # "ngspice"
      # "digital"

      ### social ###
      "whatsapp"

      ### utils ###
      # "keyclu"
      # "syncthing"
      "keka"
      # "raycast"
      # "loungy"
      # "notion-calendar"
      # "orion"
      # "spotube"
      # "arc"

      # "inkscape"
      "obs"
      "zoom"
      # "blender"
      "handbrake"
    ];
  };
}
