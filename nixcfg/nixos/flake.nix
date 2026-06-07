{
  description = "quant NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }:
  let
    system = "x86_64-linux";
    overlays = [
      (import ./overlays/dwl.nix)
    ];
  in {
    nixosConfigurations.quant = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {
        inherit overlays;
      };
      modules = [
        {
          nixpkgs.overlays = overlays;
        }
        ./hosts/quant/default.nix
      ];
    };
  };
}
