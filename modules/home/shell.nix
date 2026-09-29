{ pkgs, ... }:
{
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableZshIntegration = true;
    
    # Silence warning timeouts and avoid output lag on slow evals
    config = {
      global = {
        warn_timeout = "500ms";
        hide_env_diff = true;
      };
    };
  };

  programs.zsh = {
    enable = true;
    
    # DISABLE Home Manager's heavy Nix-store completion scanning
    enableCompletion = false; 
    
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      # REMOVED: "direnv" (causes duplicate hooks) and "docker" (causes prompt lag)
      plugins = [
        "git"
      ];
    };

    sessionVariables = {
      EDITOR = "code";
      VISUAL = "code";
    };

    shellAliases = {
      zshconfig = "code ~/.zshrc";
      nixconfig = "code ~/code/nixos-config";
      ll = "ls -lah";
    };

  };
}