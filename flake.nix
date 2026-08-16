{
  description = "NixOS SecureBoot FDE";
  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    systems.url = "github:nix-systems/default-linux";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v1.0.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    qemu-vm = {
      url = "github:andsens/nixos-qemu-vm";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-parts.follows = "flake-parts";
    };
    docs = {
      url = "github:andsens/nix-docs";
      inputs.systems.follows = "systems";
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
      {
        flake-parts-lib,
        self,
        inputs,
        ...
      }:
      let
        inherit (flake-parts-lib) importApply;
      in
      {
        systems = import systems;
        flake = {
          lib = {
            importsApply = map (path: importApply path { inherit self inputs; });
          };
          nixosModules = {
            default = importApply ./nix/modules/default { inherit self inputs; };
            installer = importApply ./nix/modules/installer { inherit self inputs; };
            vm = importApply ./nix/modules/vm { inherit self inputs; };
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
          {
            pkgs,
            system,
            lib,
            ...
          }:
          let
            options-docs = inputs.docs.lib.docs.options {
              inherit pkgs;
              modules = [
                self.nixosModules.default
                self.nixosModules.installer
              ];
              repoPath = toString self;
              repoLinkPrefix = "https://github.com/andsens/nixos-sbfde/blob/main";
            };
          in
          {
            apps.update-docs.program = inputs.docs.lib.docs.updateRepo {
              inherit pkgs;
              paths."docs/options.md" = options-docs.optionsCommonMark;
            };
            packages = {
              installer = pkgs.callPackage ./nix/packages/installer { };
              installer-vm = inputs.qemu-vm.lib.mkVMRunner {
                inherit system;
                vmName = "installer-vm";
                nixosConfiguration = self.nixosConfigurations."vm-${system}";
              };
              options-docs = options-docs.optionsCommonMark;
            };
          };
      }
    );
}
