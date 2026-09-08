{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # CLI basics
    curl
    wget
    jq
    ripgrep
    fd
    tree
    htop
    unzip

    # Git / GitHub (gh needs `gh auth login` once)
    gh

    # Containers CLI (daemon is system-level; see modules/nixos/docker.nix)
    docker-compose

    # Future-friendly: keep global shell lean; project tools via direnv
  ];
}
