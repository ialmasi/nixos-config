{
  description = "NixOS + Home Manager config (devbox)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Optional: file-based dotfiles (zsh extras, etc.)
    # Unlock 1Password / fix gh auth, then: nix flake update
    # dotfiles = {
    #   url = "github:ialmasi/dotfiles";
    #   flake = false;
    # };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      lib = nixpkgs.lib;
    in
    {
      # Use on current Linux Mint (or any non-NixOS) host:
      #   nix run home-manager -- switch --flake ~/code/nixos-config#pisti@devbox
      homeConfigurations."pisti@devbox" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { inherit self; };
        modules = [ ./hosts/devbox/home.nix ];
      };

      # Target for a future NixOS install on this machine:
      #   sudo nixos-rebuild switch --flake ~/code/nixos-config#devbox
      nixosConfigurations.devbox = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit self; };
        modules = [
          ./hosts/devbox/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = { inherit self; };
              users.pisti = import ./hosts/devbox/home.nix;
            };
          }
        ];
      };

      # Convenience: nix develop ~/code/nixos-config
      devShells.${system}.default = pkgs.mkShell {
        packages = with pkgs; [
          nixfmt-rfc-style
          nil
          git
        ];
      };

      formatter.${system} = pkgs.nixfmt-rfc-style;
    };
}
