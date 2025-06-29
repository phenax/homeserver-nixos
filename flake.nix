{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    phenax-yayarr = {
      url = "github:phenax/yayarr";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixos-hardware, phenax-yayarr, ... }: {
    nixosConfigurations.bacchus = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        settings = import ./settings.nix { inherit (nixpkgs) lib; };
        inherit nixos-hardware;
        phenax-yayarr = phenax-yayarr.packages.x86_64-linux.default;
      };
      modules = [ ./modules/config.nix ];
    };
  };
}
