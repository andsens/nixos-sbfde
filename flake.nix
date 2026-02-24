{
  description = "home-server";
  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    systems.url = "github:nix-systems/default-linux";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
  };
  outputs =
    {
      systems,
      flake-parts,
      ...
    }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } (
      {
        flake-parts-lib,
        config,
        self,
        ...
      }@mkFlakeArgs:
      let
        inherit (flake-parts-lib) importApply;
      in
      {
        systems = import systems;
        flake.nixosModules = {
          default = config.flake.nixosModules.install-nixos;
          install-nixos = args: { imports = [ (importApply ./nix mkFlakeArgs) ]; };
        };
        perSystem =
          { pkgs, ... }:
          {
            packages.install-nixos = pkgs.callPackage ./nix/installer.nix { };
          };
      }
    );
}
