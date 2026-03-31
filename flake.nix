{
  description = "NixOS SecureBoot FDE";
  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    systems.url = "github:nix-systems/default-linux";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v1.0.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    qemu-vm = {
      url = "github:andsens/nixos-qemu-vm";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-parts.follows = "flake-parts";
    };
  };
  outputs =
    {
      systems,
      flake-parts,
      nixpkgs,
      ...
    }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } (
      { flake-parts-lib, self, ... }@mkFlakeArgs:
      let
        inherit (flake-parts-lib) importApply;
      in
      {
        systems = import systems;
        flake = {
          nixosModules = {
            default = args: { imports = [ (importApply ./nix/modules/default mkFlakeArgs) ]; };
            installer = args: { imports = [ (importApply ./nix/modules/installer mkFlakeArgs) ]; };
            vm = args: { imports = [ (importApply ./nix/modules/vm mkFlakeArgs) ]; };
          };
          nixosConfigurations = {
            "iso-x86_64-linux" = nixpkgs.lib.nixosSystem {
              specialArgs = { inherit inputs self; };
              modules = [
                ./nix/configurations/iso.nix
                {
                  networking.hostName = "nixos";
                  nixpkgs.hostPlatform = "x86_64-linux";
                }
              ];
            };
            "iso-aarch64-linux" = nixpkgs.lib.nixosSystem {
              specialArgs = { inherit inputs self; };
              modules = [
                ./nix/configurations/iso.nix
                {
                  networking.hostName = "nixos";
                  nixpkgs.hostPlatform = "aarch64-linux";
                }
              ];
            };
            "vm-x86_64-linux" = nixpkgs.lib.nixosSystem {
              specialArgs = { inherit inputs self; };
              modules = [
                ./nix/configurations/vm.nix
                { nixpkgs.hostPlatform = "x86_64-linux"; }
              ];
            };
            "vm-aarch64-linux" = nixpkgs.lib.nixosSystem {
              specialArgs = { inherit inputs self; };
              modules = [
                ./nix/configurations/vm.nix
                { nixpkgs.hostPlatform = "aarch64-linux"; }
              ];
            };

          };
        };
        perSystem =
          { pkgs, system, ... }:
          {
            packages = {
              installer = pkgs.callPackage ./nix/packages/installer { };
              installer-vm = inputs.qemu-vm.lib.mkVMRunner {
                inherit system;
                vmName = "installer-vm";
                nixosConfiguration = self.nixosConfigurations."vm-${system}";
              };
            };
          };
      }
    );
}
