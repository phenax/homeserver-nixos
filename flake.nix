{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    dns = {
      url = "github:kirelagin/dns.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixos-hardware, dns, ... }: {
    nixosConfigurations.bacchus = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit dns; };
      modules = [
        "${nixos-hardware}/lenovo/ideapad"
        ./configuration.nix
      ];
    };
  };
}
