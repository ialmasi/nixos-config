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

  programs.tmux = {
    enable = true;
    clock24 = true;
    mouse = true;
    historyLimit = 50000;
    terminal = "tmux-256color";
    extraConfig = ''
      set -g base-index 1
      setw -g pane-base-index 1
      setw -g automatic-rename on
      set -g renumber-windows on
      set -g status-interval 5
      set -g escape-time 0
      set -g focus-events on
      setw -g mode-keys vi
      bind r source-file ~/.config/tmux/tmux.conf \; display-message "tmux reloaded"
      bind | split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"
    '';
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

    # Auto-attach tmux for interactive terminals only (skip Cursor/VS Code/SSH tools).
    initContent = ''
      if [[ -o interactive ]] \
        && [[ -z "$TMUX" ]] \
        && [[ -z "$VSCODE_INJECTION" ]] \
        && [[ "$TERM_PROGRAM" != "vscode" ]] \
        && [[ "$TERM_PROGRAM" != "cursor" ]] \
        && [[ -z "$CURSOR_AGENT" ]] \
        && command -v tmux >/dev/null 2>&1; then
        tmux attach-session -t default 2>/dev/null || tmux new-session -s default
      fi
    '';
  };
}