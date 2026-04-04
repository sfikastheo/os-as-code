{ config, ... }:

{
  # TODO: move into `ssh` attrset
  home.file.".ssh/allowed_signers".text = ''
    sfikastheo  ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINDhJ/rDsgb8o6xZ9F5kmVnWzpQtO0eRSNhANIiREvkb
  '';

  programs.git = {
    enable = true;
    lfs.enable = true;
    ignores = [
      ".worktrees/"
      ".claude/"
    ];

    signing = {
      format = "ssh";
      signByDefault = true;
      key = "${config.home.homeDirectory}/.ssh/signing_key";
    };

    settings = {
      init.defaultBranch = "main";
      user = {
        name = "sfikastheo";
        email = "theodore.sfikas@toolsforhumanity.com";
      };

      gpg.ssh.allowedSignersFile = "${config.home.homeDirectory}/.ssh/allowed_signers";

      merge = {
        tool = "nvimdiff";
        conflictstyle = "zdiff3";
      };

      color = {
        interactive = true;
        branch = true;
        status = true;
      };

      url = {
        "ssh://github.com/worldcoin" = {
          insteadOf = "https://github.com/worldcoin";
        };
      };

      alias = {
        root = "rev-parse --show-toplevel";
        unstage = "reset HEAD";
        sh = "show --color";

        co = "checkout";
        cb = "checkout -b";
        st = "status";

        rf = "reflog";

        cm = "commit";
        cmf = "commit --allow-empty";
        ca = "commit --amend";
        caf = "commit --amend --no-edit --allow-empty";
        cu = "reset HEAD^1";

        me = "merge --no-edit";
        mu = "reset --merge";

        lo = "log -m --simplify-merges --color --pretty=format:'%Cred%h%Creset %s %Cgreen(%cr) %Cblue%an <%ae>%Creset' --abbrev-commit";
        lg = "log --graph --date=short --decorate --first-parent --pretty=format:'%C(auto)%h %ad %d %s'";
        lga = "log --graph --date=short --decorate --all --pretty=format:'%C(auto)%h %ad %d %s'";

        df = "diff --color";
        dfs = "diff --staged --color";

        f = "fetch";
        fa = "fetch --all";
        fo = "fetch origin";
        fu = "fetch upstream";

        ps = "push";
        psf = "push -f";
        psb = "!git push -u origin $(git branch --show-current)";

        pl = "pull";
        plo = "pull origin";
        plf = ''!f() { git fetch origin "$1" && git reset --hard origin/"$1"; }; f'';

        a = "add";
        aa = "add --all";
        af = "add --all -f";

        shl = "stash list";
        shp = "stash pop";
        shd = "stash drop";
        shc = "stash clear";
        sha = "stash apply";

        ch = "cherry-pick";
        chc = "cherry-pick --continue";
        chq = "cherry-pick --quit";
        cha = "cherry-pick --abort";

        rv = "revert";
        rvc = "revert --continue";
        rva = "revert --abort";

        rb = "rebase";
        rbi = "rebase -i";
        rbc = "rebase --continue";
        rba = "rebase --abort";
        rbs = "rebase --skip";

        wta = "worktree add";
        wtl = "worktree list";
        wtr = "worktree remove";
        wtm = "worktree move";

        br = "branch";
        brd = "branch -D";
        bru = "branch --set-upstream";
        brr = "!git branch --set-upstream-to=origin/$(git branch --show-current)";
      };

    };
  };

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
  };
}
