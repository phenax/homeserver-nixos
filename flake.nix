{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
  };

  outputs = { self, nixpkgs, nixos-hardware, ... }: {
    nixosConfigurations.bacchus = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        "${nixos-hardware}/lenovo/ideapad"
        ./configuration.nix
      ];
    };
  };
}
