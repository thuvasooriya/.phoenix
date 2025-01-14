{
  config,
  pkgs,
  lib,
  myvars,
  ...
}: let
  gitIgnoreGlobal =
    builtins.toFile "gitignore_global"
    ''
      # compiled source
      *.com
      *.class
      *.dll
      *.exe
      *.o
      *.so
      *.out

      # virtual environments
      **/.venv

      # logs and databases
      *.log
      *.sql
      *.sqlite

      # os generated files
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
      userName = myvars.userfullname;
      userEmail = myvars.useremail;
      # userEmail = "74165167+thuvasooriya@users.noreply.github.com";
      aliases = {
        a = "add";
        aa = "add --all";
        d = "diff";
        dc = "diff --cached";
        pl = "pull";
        pu = "push";
        puf = "push --force";
        s = "status";

        # checkout commands
        co = "checkout";
        cob = "checkout -b";
        com = "checkout master";

        # commit commands
        amend = "commit --amend --no-edit";
        c = "commit";
        ca = "commit -a";
        cam = "commit -a -m";
        cm = "commit -m";

        # rebase commands
        rb = "rebase";
        rba = "rebase --abort";
        rbc = "rebase --continue";
        rbi = "rebase --interactive";
        rbs = "rebase --skip";

        # reset commands
        r = "reset HEAD";
        r1 = "reset HEAD^";
        r2 = "reset HEAD^^";
        rhard = "reset --hard";
        rhard1 = "reset HEAD^ --hard";
        rhard2 = "reset HEAD^^ --hard";

        # stash commands
        sd = "stash drop";
        spo = "stash pop";
        spu = "stash push";
        spua = "stash push --all";

        # other commands
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
        commit.gpgsign = true;
        gpg.format = "ssh";
        user.signingkey = "~/.ssh/id_ed25519.pub";
      };
      lfs = {
        enable = true;
        skipSmudge = true;
      };
    };
  };
}
