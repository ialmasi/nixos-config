# NixOS system config for host "devbox".
# This machine currently runs Linux Mint + Nix (Home Manager).
# When installing NixOS:
#   1. Generate hardware-configuration.nix during install
#   2. Place it next to this file and uncomment the import
#   3. sudo nixos-rebuild switch --flake ~/code/nixos-config#devbox
{
  imports = [
    ../../modules/nixos
    # ./hardware-configuration.nix
  ];

  networking.hostName = "devbox";

  # Boot / filesystems come from hardware-configuration.nix after install.
  # Placeholder so the flake evaluates; replace before real NixOS boot.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "ext4";
  };

  system.stateVersion = "25.05";
}
