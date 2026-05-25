{
  description = "quant NixOS configuration";

  inputs = {
    nixpkgs.url          = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, ... }: {
    nixosConfigurations.quant = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./hosts/quant/default.nix
      ];
    };
  };
}
