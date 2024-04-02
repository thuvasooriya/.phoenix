{pkgs, ...}: let
  gitIgnoreGlobal =
    builtins.toFile "gitignore_global"
    ''
      # Compiled source
      *.com
      *.class
      *.dll
      *.exe
      *.o
      *.so
      *.out

      # Virtual environments
      **/.venv

      # Logs and databases
      *.log
      *.sql
      *.sqlite

      # OS generated files
      .DS_Store
      .DS_Store?
      ._.DS_Store
      **/.DS_Store
      **/._.DS_Store
      ._*
      .Spotlight-V100
      .Trashes
      ehthumbs.db
      Thumbs.db
    '';
in {
  home = {
    packages = with pkgs; [
      tig
    ];
  };
  programs = {
    gh.enable = true;
    lazygit.enable = true;
    git = {
      enable = true;
      userName = "thuvasooriya";
      userEmail = "thuvasooriya@gmail.com";
      aliases = {
        # Basic commands
        a = "add";
        aa = "add --all";
        d = "diff";
        dc = "diff --cached";
        pl = "pull";
        pu = "push";
        puf = "push --force";
        s = "status";

        # Checkout commands
        co = "checkout";
        cob = "checkout -b";
        com = "checkout master";

        # Commit commands
        amend = "commit --amend --no-edit";
        c = "commit";
        ca = "commit -a";
        cam = "commit -a -m";
        cm = "commit -m";

        # Rebase commands
        rb = "rebase";
        rba = "rebase --abort";
        rbc = "rebase --continue";
        rbi = "rebase --interactive";
        rbs = "rebase --skip";

        # Reset commands
        r = "reset HEAD";
        r1 = "reset HEAD^";
        r2 = "reset HEAD^^";
        rhard = "reset --hard";
        rhard1 = "reset HEAD^ --hard";
        rhard2 = "reset HEAD^^ --hard";

        # Stash commands
        sd = "stash drop";
        spo = "stash pop";
        spu = "stash push";
        spua = "stash push --all";

        # Other commands
        lg = "log --graph --abbrev-commit --decorate --format=format:'%C(blue)%h%C(reset) - %C(green)(%ar)%C(reset) %s %C(italic)- %an%C(reset)%C(magenta bold)%d%C(reset)' --all";
        rs = "restore --staged";
        pushf = "push --force-with-lease"; # only force pushes if no new commits have pushed after the last pull
        blamex = "blame -w -C -C -C"; # ignores whitespaces and code that has just been moved around
        diffw = "diff --word-diff"; # inline diff
        stasha = "stash --all"; # stash even untracked and ignored files
      };
      delta = {
        enable = true;
        options = {
          navigate = true;
          line-numbers = true;
          syntax-theme = "Dracula";
        };
      };
      difftastic = {
        #enable = true;
        background = "dark";
        #display = "side-by-side"; # "side-by-side", "side-by-side-show-both", "inline"
      };
      extraConfig = {
        init.defaultBranch = "main";
        core = {
          editor = "nvim";
          excludesFile = "${gitIgnoreGlobal}";
        };
        pull.ff = "only";
        merge.conflictstyle = "diff3";
        rerere = {
          enabled = true;
          autoUpdate = true;
        };
        column.ui = "auto";
        color.ui = true;
        branch.sort = "-committerdate";
        #core.fsmonitor = true; # watch FS for faster git status
      };
      # signing = {
      # key = "4AB1353033774DA3";
      # };
      lfs = {
        enable = true;
        skipSmudge = true;
      };
    };
  };
}
