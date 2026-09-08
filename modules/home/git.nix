{ ... }:
{
  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "Almási István";
        # Change in hosts/devbox/home.nix if you prefer a real address
        email = "4927676+ialmasi@users.noreply.github.com";
      };

      alias = {
        co = "checkout";
        br = "branch";
        ci = "commit";
        st = "status -sb";
        last = "log -1 HEAD";
        unstage = "reset HEAD --";
        amend = "commit --amend --no-edit";
        undo = "reset --soft HEAD~1";
        lg = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative --all";
        df = "diff";
        dfc = "diff --cached";
        prune-merged = "!git branch --merged | grep -v '\\*' | xargs -r git branch -d";
      };

      init.defaultBranch = "main";

      core = {
        editor = "code --wait";
        autocrlf = "input";
        eol = "lf";
        whitespace = "trailing-space,space-before-tab";
        pager = "less -FRX";
      };

      pull.rebase = true;
      push.autoSetupRemote = true;
      fetch.prune = true;
      rebase.autoStash = true;

      color.ui = "auto";

      diff.algorithm = "histogram";
      merge.conflictstyle = "zdiff3";

      advice.detachedHead = false;
    };

    ignores = [
      ".DS_Store"
      "*~"
      "*.swp"
      ".direnv/"
      ".env"
      ".env.local"
    ];
  };
}
