{ config, pkgs, ... }:
{
  imports = [ ../../modules/home ];

  home = {
    username = "pisti";
    homeDirectory = "/home/pisti";
    stateVersion = "25.05";
  };

  # Standalone HM on Mint: manage itself
  programs.home-manager.enable = true;

  # Uncomment / edit if GitHub noreply is not what you want:
  # programs.git.userEmail = "you@example.com";

  nixpkgs.config.allowUnfree = true;
}
