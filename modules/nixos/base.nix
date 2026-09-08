{ pkgs, ... }:
{
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    trusted-users = [
      "root"
      "pisti"
    ];
  };

  nixpkgs.config.allowUnfree = true;

  time.timeZone = "Europe/Budapest";
  i18n.defaultLocale = "en_US.UTF-8";

  programs.zsh.enable = true;
  users.users.pisti = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "docker"
    ];
    shell = pkgs.zsh;
  };

  environment.systemPackages = with pkgs; [
    vim
    git
    wget
    curl
  ];
}
