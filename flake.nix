{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
  };

  outputs = { self, nixpkgs, nixos-hardware, ... }: {
    nixosConfigurations.bacchus = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        settings = import ./settings.nix { inherit (nixpkgs) lib; };
        inherit nixos-hardware;
      };
      modules = [ ./modules/config.nix ];
    };
  };
}
