{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    neovim
    fish
    git
    just # use Justfile to simplify nix-darwin's commands
  ];

  ## todo: ghostty terminfo config for sbcs
  # TERMINFO_DIRS = "${pkgs.kitty.terminfo.outPath}/share/terminfo";
  environment.variables.EDITOR = "nvim";
  environment.shells = [pkgs.bashInteractive pkgs.zsh pkgs.fish];
  programs.nix-index.enable = true;
  programs.man.enable = true;
  programs.zsh = {
    enable = true;
    enableFzfCompletion = true;
    # enableFzfGit = true;
    enableFzfHistory = true;
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
      if test (uname -m) = "arm64"
          eval (/opt/homebrew/bin/brew shellenv)
      end
    '';
  };
  programs.bash = {
    enable = true;
    enableCompletion = true;
  };

  # services.karabiner-elements.enable = true;

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
      "krtirtho/apps"
      "mongodb/brew"
    ];

    # `brew install`
    brews = [
      "latexindent"
      "octave"
      "mongodb-community@7.0"

      # "wget" # download tool
      # "curl" # no not install curl via nixpkgs, it's not working well on macOS!
      # "aria2" # download tool
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

      # digital design tools
      "logisim-evolution"
      "ltspice"
      "wireshark"
      # "kicad"
      # "ngspice"
      # "digital"

      # utils
      "keyclu"
      "notion"
      "notion-calendar"
      "obsidian"
      "telegram"
      "whatsapp"
      # "discord"
      "orion"
      # "syncthing"
      # "spotube"
      # "arc"
      "obs"
      "zoom"
      "keka"
      "skim"
      # "selfcontrol"
      # "loungy"
      # "raycast"
      "anki"
      # "blender"
      "handbrake"
      # "utm"

      # "iina" # video player
      # "stats" # beautiful system monitor
      # "eudic" # 欧路词典

      # "insomnia" # REST client
    ];
  };
}
